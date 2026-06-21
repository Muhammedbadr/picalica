class Avo::Resources::User < Avo::BaseResource
  def fields
    field :id, as: :id
    field :email, as: :text
    field :name, as: :text
    field :lastname, as: :text
    field :username, as: :text
    field :country, as: :country
    field :date_of_birth, as: :date
    field :phone_number, as: :text
    field :bio, as: :textarea
    field :stripe_customer_id, as: :text
    
    # Use 'select' for your enum instead of 'belongs_to'
    field :role, as: :select, enum: ::User.roles

    field :orders, as: :has_many
    field :products, as: :has_many
    field :cart, as: :has_one
    field :reviews, as: :has_many
    
    # Remove: field :user_roles, as: :has_many
    # Remove: field :role, as: :belongs_to
  end
end