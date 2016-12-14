Rails.application.routes.draw do
  resources :posts, module: 'posts' do
    resources :archives
    resources :votes
    resources :shares
  end
end
