def run
  DataShape
    .init
    .data(:component_name) do
      image                 "https://images.unsplash.com/photo-1606660265514-358ebbadc80d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1575&q=80"
      brand                 "Brand"
      welcome_back_message  "Welcome Back"
      google_label          "Sign in with Google"
      alternate_label       "or login with email"
      email_label           "Email Address"
      password_label        "Password"
      forgot_password_label "Forget Password?"
      submit_label          "Login"
      signup_label          "or sign up"
    end
end

# {
#   "component_name": "simple_login",
#   "data": {
#     "brand": "Brand",
#     "welcome_back_message": "Welcome Back",
#     "message": "Login or create account",
#     "email_label": "Email Address",
#     "password_label": "Password",
#     "forgot_password_label": "Forget Password?",
#     "submit_label": "Login",
#     "no_account_label": "Don't have an account?",
#     "register_label": "Register"
#   }
# },
# {
#   "component_name": "full_page_with_image",
#   "data": {
#     "image": "https://images.unsplash.com/photo-1616763355603-9755a640a287?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
#     "brand": "Brand",
#     "welcome_back_message": "Welcome Back",
#     "message": "Sign in to access your account",
#     "email_label": "Email Address",
#     "password_label": "Password",
#     "forgot_password_label": "Forget Password?",
#     "submit_label": "Sign in",
#     "no_account_label": "Don't have an account?",
#     "sign_up_label": "Sign up"
#   }
# },
# {
#   "component_name": "login_with_social_media_links",
#   "data": {
#     "brand": "Brand",
#     "username_label": "Username",
#     "password_label": "Password",
#     "login_label": "Login",
#     "social_media_label": "or login with Social Media",
#     "google_label": "Sign in with Google",
#     "no_account_label": "Don't have an account?",
#     "create_account_label": "Create One"
#   }
# }
