class NotificationSettingsController < SignedInApplicationController
  using RefinedString
  using RefinedInteger

  before_action :require_write_access!, only: %i[update]
  before_action :set_train, only: %i[index update]
  before_action :set_notification_setting, only: %i[update]
  around_action :set_time_zone

  def index
    @notification_settings = @train.notification_settings
  end

  def update
    head :forbidden and return unless @train.send_notifications?

    if @notification_setting.update(parsed_notif_setting_params)
      redirect_to app_train_notification_settings_path(@app, @train), notice: "Notification setting was updated"
    else
      @notification_settings = @train.notification_settings
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_notification_setting
    @notification_setting = @train.notification_settings.find(params[:id])
  end

  def set_train
    @train = @app.trains.friendly.find(params[:train_id])
  end

  def notif_setting_params
    params.require(:notification_setting).permit(
      :active,
      notification_channels: []
    )
  end

  def parsed_notif_setting_params
    notif_setting_params.merge(notification_channels: notification_channels)
  end

  def notification_channels
    notif_setting_params[:notification_channels]&.compact_blank&.map(&:safe_json_parse)
  end
end
