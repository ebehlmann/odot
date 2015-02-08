require 'spec_helper'

describe "Editing todo items" do
	let!(:todo_list) { TodoList.create(title: "Groceries list", description: "Groceries to buy") }
	let!(:todo_item) { todo_list.todo_items.create(content: "Milk") }

	it "successfully deletes" do
		visit_todo_list(todo_list)
		within "#todo_item_#{todo_item.id}" do
			click_link "Delete"
		end
		expect(page).to have_content("Todo item was deleted")
		expect(TodoItem.count).to eq(0)
	end
end