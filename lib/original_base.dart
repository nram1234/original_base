library original_base;

// configurations
export 'src/config/palette.dart';
export 'src/config/app_theme.dart';
export 'src/config/typography.dart';
export 'src/config/hive_boxes.dart';

// models
export 'src/core/models/user.dart';
export 'src/core/models/home_banner.dart';
export 'src/core/models/selectable_type.dart';
//--------------------------------------------
export 'src/core/models/product/product.dart';
export 'src/core/models/product/cart_item.dart';
export 'src/core/models/product/favorite_product.dart';
export 'src/core/models/product/product_attribute.dart';
//------------------------------------------------------
export 'src/core/models/store/store.dart';
export 'src/core/models/store/store_city.dart';
export 'src/core/models/store/trade_type.dart';
export 'src/core/models/store/store_review.dart';
export 'src/core/models/store/store_category.dart';
//-------------------------------------------------
export 'src/core/models/chat/chat_room.dart';
export 'src/core/models/chat/chat_message.dart';
export 'src/core/models/chat/chat_message_type.dart';
//---------------------------------------------------
export 'src/core/models/results/http_client_result.dart';
export 'src/core/models/results/image_picker_result.dart';
//--------------------------------------------------------
export 'src/core/models/car/car.dart';
export 'src/core/models/car/car_brand.dart';
export 'src/core/models/car/car_model.dart';
export 'src/core/models/car/car_engine.dart';
export 'src/core/models/original_app_type.dart';
export 'src/core/models/car/year_of_manufacture.dart';

// services
export 'src/core/services/car_types/car_brands_client.dart';
export 'src/core/services/car_types/car_models_client.dart';
export 'src/core/services/car_types/car_engines_client.dart';
export 'src/core/services/car_types/manufacture_years_client.dart';
//-----------------------------------------------------------------
export 'src/core/services/chat/chat_rooms_client.dart';
export 'src/core/services/chat/new_chat_room_client.dart';
export 'src/core/services/chat/private_chat_room_client.dart';
//------------------------------------------------------------
export 'src/core/services/localization/app_localization.dart';
export 'src/core/services/localization/localization_helper.dart';
//---------------------------------------------------------------
export 'src/core/services/local_storage/logged_in_user_helper.dart';
export 'src/core/services/local_storage/locale_helper.dart';
export 'src/core/services/local_storage/hive_caching_client.dart';
//---------------------------------------------------------------
export 'src/core/services/notifications/local_notifications_service.dart';
export 'src/core/services/notifications/firebase_messaging_service.dart';
export 'src/core/services/notifications/push_token_client.dart';
//--------------------------------------------------------------
export 'src/core/services/auth/logout_client.dart';
export 'src/core/services/auth/token_revoke_client.dart';
//-------------------------------------------------------
export 'src/core/services/shared/image_picker_tool.dart';
export 'src/core/services/shared/expire_date_formatter.dart';
export 'src/core/services/shared/merchants_cities_client.dart';
export 'src/core/services/shared/min_app_version_service.dart';
export 'src/core/services/shared/technical_support_client.dart';
export 'src/core/services/shared/user_online_status_client.dart';
export 'src/core/services/shared/sailor_navigation_service.dart';
export 'src/core/services/shared/phone_number_update_client.dart';

// utilities
export 'src/core/utils/time_ago_util.dart';
export 'src/core/utils/app_store_rating.dart';
export 'src/core/utils/strings_validator.dart';
export 'src/core/utils/cached_image_util.dart';
export 'src/core/utils/numeral_extensions.dart';
export 'src/core/utils/client_error_resolver.dart';
export 'src/core/utils/assets_bytes_converter.dart';

// view_models
export 'src/core/view_models/auth/reset_password_notifier.dart';
export 'src/core/view_models/auth/forgot_password_notifier.dart';
//---------------------------------------------------------------
export 'src/core/view_models/merchants_cities_notifier.dart';
export 'src/core/view_models/drawer_controller_provider.dart';
export 'src/core/view_models/animated_drawer_controller.dart';
//------------------------------------------------------------
export 'src/core/view_models/car_types/car_brands_notifier.dart';
export 'src/core/view_models/car_types/car_models_notifier.dart';
export 'src/core/view_models/car_types/car_engines_notifier.dart';
export 'src/core/view_models/car_types/years_of_manufacture_notifier.dart';
//-------------------------------------------------------------------------
export 'src/core/view_models/chat/peer_info_provider.dart';
export 'src/core/view_models/chat/private_chat_room_notifier.dart';
export 'src/core/view_models/chat/chat_room_redirect_handler.dart';

// animation
export 'src/ui/animation/star_rating.dart';
export 'src/ui/animation/animated_drawer.dart';
export 'src/ui/animation/carousel_indicator.dart';
export 'src/ui/animation/animation_gesture_detector.dart';

// responsive layout
export 'src/ui/responsive_layout/size_extension.dart';
export 'src/ui/responsive_layout/responsive_layout.dart';
export 'src/ui/responsive_layout/responsive_initializer.dart';

// reusable widgets
export 'src/ui/widgets/contact_info.dart';
export 'src/ui/widgets/issue_resolver.dart';
export 'src/ui/widgets/failure_widget.dart';
//------------------------------------------
export 'src/ui/widgets/loading/loading_popup.dart';
export 'src/ui/widgets/popups/dashboard_wrapper_pop_scope.dart';
export 'src/ui/widgets/loading/circular_loading_indicator.dart';
//--------------------------------------------------------------
export 'src/ui/widgets/product/review_card.dart';
export 'src/ui/widgets/product/product_summary.dart';
export 'src/ui/widgets/product/discount_banner.dart';
export 'src/ui/widgets/product/product_details_card.dart';
export 'src/ui/widgets/product/product_status_badge.dart';
//--------------------------------------------------------
export 'src/ui/widgets/input/types_selector.dart';
export 'src/ui/widgets/input/sms_code_entry.dart';
export 'src/ui/widgets/input/original_checkbox.dart';
export 'src/ui/widgets/input/original_text_field.dart';
//-----------------------------------------------------
export 'src/ui/widgets/items/choice_item.dart';
export 'src/ui/widgets/items/navbar_item.dart';
export 'src/ui/widgets/items/car_brand_choice.dart';
export 'src/ui/widgets/items/picked_image_item.dart';
//---------------------------------------------------
export 'src/ui/widgets/carousel/intro_carousel.dart';
export 'src/ui/widgets/carousel/images_carousel.dart';
export 'src/ui/widgets/carousel/pagination_index.dart';
//-----------------------------------------------------
export 'src/ui/widgets/popups/loading_overlay.dart';
export 'src/ui/widgets/popups/snack_bar_alert.dart';
export 'src/ui/widgets/popups/image_source_popup.dart';
export 'src/ui/widgets/popups/interception_alert.dart';
//-----------------------------------------------------
export 'src/ui/widgets/buttons/action_button.dart';
export 'src/ui/widgets/buttons/social_button.dart';
export 'src/ui/widgets/buttons/navigation_button.dart';
export 'src/ui/widgets/buttons/image_picker_button.dart';
export 'src/ui/widgets/buttons/multi_choices_button.dart';
export 'src/ui/widgets/buttons/drawer_action_button.dart';
//--------------------------------------------------------
export 'src/ui/widgets/layout/map_view.dart';
export 'src/ui/widgets/layout/dotted_border.dart';
export 'src/ui/widgets/layout/screen_header.dart';
export 'src/ui/widgets/layout/dialog_scaffold.dart';
export 'src/ui/widgets/layout/scaffold_curved_body.dart';
//-------------------------------------------------------
export 'src/ui/widgets/chat/screens/chat_rooms_screen.dart';
export 'src/ui/widgets/chat/screens/private_chat_room_screen.dart';
//-----------------------------------------------------------------
export 'src/ui/widgets/chat/components/chat_room_card.dart';
export 'src/ui/widgets/chat/components/peer_contact_card.dart';
export 'src/ui/widgets/chat/components/chat_message_bubble.dart';
export 'src/ui/widgets/chat/components/chat_room_bottom_bar.dart';
export 'src/ui/widgets/chat/components/firestore_pagination_widget.dart';
