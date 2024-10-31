class CreateUserActionNotificationService
  attr_accessor :actor_id, :action, :user_task_id

  def initialize(actor_id, action, user_task_id)
    @actor_id = actor_id
    @action = action
    @user_task_id = user_task_id
  end

  def perform
    raise ArgumentError.new("Invalid arguments!") unless valid_parameters?

    UserActionNotification.create(
      actor_id: actor_id,
      action: action,
      user_task_id: user_task_id
    )
  end

  private

  def valid_parameters?
    valid_actor_id? && valid_action? && valid_user_task_id?
  end

  def valid_actor_id?
    valid_non_negative_number_parameter?(actor_id, "actor id")
  end

  def valid_action?
    valid_non_empty_string_parameter?(action.dup, "action")
  end

  def valid_user_task_id?
    valid_non_negative_number_parameter?(user_task_id, "user task id")
  end

  def valid_non_empty_string_parameter?(parameter, parameter_name)
    raise ArgumentError.new("Invalid #{parameter_name}!") unless parameter

    parameter.strip!
    raise ArgumentError.new("Invalid #{parameter_name}!") if parameter.empty?

    true
  end

  def valid_non_negative_number_parameter?(parameter, parameter_name)
    raise ArgumentError.new("Invalid #{parameter_name}!") unless parameter

    raise ArgumentError.new("Invalid #{parameter_name}!") if parameter.to_i < 0

    true
  end
end
