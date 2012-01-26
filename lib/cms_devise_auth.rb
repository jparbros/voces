module CmsDeviseAuth
  def authenticate
    unless current_admin
      redirect_to new_admin_session_path
    end
  end
end