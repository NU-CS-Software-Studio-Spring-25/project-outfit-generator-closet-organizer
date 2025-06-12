# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.1.0/lib/assets/compiled/rails-ujs.js"
pin "validate_new_clothing_form"
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js", preload: true
pin "chartkick", to: "https://cdn.jsdelivr.net/npm/chartkick@4.2.0/dist/chartkick.js", preload: true
pin "Chart.bundle", to: "https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.js", preload: true

