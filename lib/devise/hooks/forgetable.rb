# Before logout hook to forget the user in the given scope, if it responds
# to forget_me! Also clear remember token to ensure the user won't be
# remembered again. Notice that we forget the user unless the record is frozen.
# This avoids forgetting deleted users.
Warden::Manager.before_logout do |record, warden, options|
  if record.respond_to?(:forget_me!)
    record.forget_me! unless record.frozen?

    warden.cookies.delete("remember_#{options[:scope].to_s}_token", :domain => record.cookie_domain, :path => "/")
  end
end
