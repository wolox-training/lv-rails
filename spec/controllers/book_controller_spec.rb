require 'rails_helper'

describe BookController do
  login_user

  it 'get index' do
    get 'index', params: { book: { author: 'King' } }
    expect(response).to be_success
  end

  it 'get show' do
    get 'show', params: { book: { id: 1 } }
    expect(response).to be_success
  end
end
