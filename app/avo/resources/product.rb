class Avo::Resources::Product < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :user_id, as: :number
    field :heading, as: :text
    field :title, as: :text
    field :description, as: :textarea
    field :story, as: :text
    field :position, as: :text
    field :exclusive_product, as: :boolean
    field :issue_number, as: :text
    field :preview_url, as: :text
    field :category_id, as: :number
    field :subcategory_id, as: :number
    field :user, as: :belongs_to
    field :subcategory, as: :belongs_to
    field :feature_sections, as: :has_many
    field :cart_items, as: :has_many
    field :carts, as: :has_many, through: :cart_items
    field :order_items, as: :has_many
    field :orders, as: :has_many, through: :order_items
    field :reviews, as: :has_many
    field :images, as: :has_many
    field :videos, as: :has_many
    field :texts, as: :has_many
    field :lists, as: :has_many
    field :licenses, as: :has_many
    field :product_files, as: :has_many
  end
end
