Rails.application.routes.draw do
  # ===== Logowanie =====
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # ===== Dashboard =====
  root "studios#dashboard"
  get "dashboard", to: "studios#dashboard"

  # ===== Studenci =====
  resources :students do
    member do
      get :pdf   # /students/:id/pdf
    end
  end

  # ===== Turbo: semestry studenta =====
  get "students/:id/semester/:semester_id",
      to: "students#semester",
      as: :student_semester

  # ===== Ranking =====
  get "ranking/:semester_id",
      to: "students#ranking",
      as: :ranking

  # ===== Zasoby =====
  resources :courses
  resources :groups
  resources :grades, only: [:create, :destroy]
  resources :studios

  # ===== Turbo: dashboard dziekana =====
  get "dashboard/semester/:id",
      to: "studios#semester",
      as: :dashboard_semester

  # ===== Healthcheck =====
  get "up" => "rails/health#show", as: :rails_health_check
end
