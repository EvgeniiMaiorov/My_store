class ItemsMailer < ActionMailer::Base
  default from: "info@mystore.localhost",
          template_path: 'mailers/items'

  def item_destroyed(item)
    @item = item
    mail to: 'killer9911@mail.ru',
    subject: "Item destroyed"
  end
end
