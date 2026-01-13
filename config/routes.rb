Rails.application.routes.draw do
  get "sessions/new"
  # ===== Logowanie dziekana =====
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

  # ===== Zasoby =====
  resources :courses
  resources :groups
  resources :studios
  resources :grades, only: [:create, :destroy]

  # ===== Turbo Frames =====

  # Widok semestru studenta (Turbo)
  get "students/:id/semester/:semester_id",
      to: "students#semester",
      as: :student_semester

  # Widok semestru na dashboardzie dziekana
  get "dashboard/semester/:id",
      to: "studios#semester",
      as: :dashboard_semester

  # Ranking studentów w danym semestrze
  get "ranking/:semester_id",
      to: "students#ranking",
      as: :ranking

  # ===== Healthcheck =====
  get "up" => "rails/health#show", as: :rails_health_check

  get  "/login",  to: "sessions#new"
  post "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

end
