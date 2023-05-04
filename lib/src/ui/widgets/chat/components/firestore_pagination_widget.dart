import 'dart:io';
import 'dart:math';
//-----------------
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
//--------------------------------------------------------------
import 'package:original_base/src/core/view_models/firestore_pagination_bloc/pagination_listeners.dart';
import 'package:original_base/src/core/view_models/firestore_pagination_bloc/pagination_cubit.dart';
import 'package:original_base/src/ui/widgets/loading/circular_loading_indicator.dart';
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/ui/widgets/failure_widget.dart';
import 'package:original_base/src/config/app_theme.dart';
//-------------------------------------------------------

class FirestorePaginationWidget extends StatefulWidget {
  final bool reverse;
  final bool isLive;

  final int itemsPerPage;

  final double topPadding;

  final Query query;

  final List<ChangeNotifier>? listeners;

  final ScrollController? scrollController;

  final DocumentSnapshot? startAfterDocument;

  final Widget initialLoader;
  final Widget bottomLoader;
  final Widget emptyDisplay;

  final void Function(PaginationLoaded)? onReachedEnd;
  final void Function(PaginationLoaded)? onLoaded;

  final Widget Function(int, BuildContext, DocumentSnapshot) itemBuilder;

  const FirestorePaginationWidget({
    this.reverse = false,
    this.isLive = false,
    required this.itemsPerPage,
    this.topPadding = 25.0,
    required this.query,
    this.listeners,
    this.scrollController,
    this.startAfterDocument,
    this.initialLoader = const CircularLoadingIndicator(),
    this.bottomLoader = const CircularLoadingIndicator(),
    this.emptyDisplay = const SizedBox(),
    this.onReachedEnd,
    this.onLoaded,
    required this.itemBuilder,
    Key? key,
  }) : super(key: key);

  @override
  _FirestorePaginationWidgetState createState() =>
      _FirestorePaginationWidgetState();
}

class _FirestorePaginationWidgetState extends State<FirestorePaginationWidget> {
  PaginationCubit? _cubit;

  @override
  void initState() {
    if (widget.listeners != null) {
      for (var listener in widget.listeners!) {
        if (listener is PaginateRefreshedChangeListener) {
          listener.addListener(() {
            if (listener.refreshed) {
              _cubit!.refreshPaginatedList();
            }
          });
        } else if (listener is PaginateFilterChangeListener) {
          listener.addListener(() {
            if (listener.searchTerm.isNotEmpty) {
              _cubit!.filterPaginatedList(listener.searchTerm);
            }
          });
        }
      }
    }

    _cubit = PaginationCubit(
      widget.query,
      widget.itemsPerPage,
      widget.startAfterDocument,
      isLive: widget.isLive,
    )..fetchPaginatedList();
    super.initState();
  }

  Widget _buildErrorWidget(Exception exception) {
    bool networkError = exception is SocketException;
    if (!networkError) {
      FirebaseCrashlytics.instance.recordError(
        exception,
        null,
        reason: "firestore internal error on chat rooms",
      );
    }
    return FailureWidget(
      bottomPadding: widget.topPadding + SharedStyles.screenHeaderHeight,
      title: networkError
          ? "#network_error".translate(context)
          : "#internal_error".translate(context),
      failureType: FailureType.networkError,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginationCubit, PaginationState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state is PaginationInitial) {
          return widget.initialLoader;
        } else if (state is PaginationError) {
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              child: _buildErrorWidget(state.error),
              height: MediaQuery.of(context).size.height,
            ),
          );
        } else {
          final loadedState = state as PaginationLoaded;
          if (widget.onLoaded != null) {
            widget.onLoaded!(loadedState);
          }
          if (loadedState.hasReachedEnd && widget.onReachedEnd != null) {
            widget.onReachedEnd!(loadedState);
          }

          if (loadedState.documentSnapshots.isEmpty) {
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                child: widget.emptyDisplay,
                height: MediaQuery.of(context).size.height,
              ),
            );
          }
          return _buildListView(loadedState);
        }
      },
    );
  }

  Widget _buildListView(PaginationLoaded loadedState) {
    var listView = CustomScrollView(
      reverse: widget.reverse,
      controller: widget.scrollController,
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(top: widget.topPadding),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final itemIndex = index ~/ 2;
                if (index.isEven) {
                  if (itemIndex >= loadedState.documentSnapshots.length) {
                    _cubit!.fetchPaginatedList();
                    return widget.bottomLoader;
                  }
                  return widget.itemBuilder(itemIndex, context,
                      loadedState.documentSnapshots[itemIndex]);
                }
                return const SizedBox();
              },
              semanticIndexCallback: (widget, localIndex) {
                if (localIndex.isEven) {
                  return localIndex ~/ 2;
                }
                // ignore: avoid_returning_null
                return null;
              },
              childCount: max(
                  0,
                  (loadedState.hasReachedEnd
                              ? loadedState.documentSnapshots.length
                              : loadedState.documentSnapshots.length + 1) *
                          2 -
                      1),
            ),
          ),
        ),
      ],
    );

    if (widget.listeners != null && widget.listeners!.isNotEmpty) {
      return MultiProvider(
        providers: widget.listeners!
            .map((_listener) => ChangeNotifierProvider(
                  create: (context) => _listener,
                ))
            .toList(),
        child: listView,
      );
    }

    return listView;
  }

  @override
  void dispose() {
    widget.scrollController?.dispose();
    _cubit?.dispose();
    super.dispose();
  }
}
