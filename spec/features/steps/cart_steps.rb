module CartSteps
  
  # visit if not there already
  def go_here (path)
    visit path unless current_path == path
  end
  
  def search(values={})
    values.symbolize_keys!
    retry_on_timeout do
      fill_in 'q', with: values[:q] unless values[:q].nil?
      click_button 'search'
    end
  end
  
  def submit_login_form(values={})
    values.symbolize_keys!
    retry_on_timeout do
      go_here '/users/sign_in'
      fill_in 'user_email', with: values[:email] unless values[:email].nil?
      fill_in 'user_password', with: values[:password] unless values[:password].nil?
      check 'user_remember_me' unless [true, 1, '1'].include? values[:remember_me]  
      click_button 'Log in'
    end
  end
  
  def handle_js_confirm(accept=true)
    page.evaluate_script "window.original_confirm_function = window.confirm"
    page.evaluate_script "window.confirm = function(msg) { return #{!!accept}; }"
    yield
    page.evaluate_script "window.confirm = window.original_confirm_function"
  end
  
  def retry_on_timeout(n = 3, &block)
    block.call
  rescue Capybara::ElementNotFound => e
    if n > 0
      puts "Catched error: #{e.message}. #{n-1} more attempts."
      retry_on_timeout(n - 1, &block)
    else
      raise
    end
  end
  
end