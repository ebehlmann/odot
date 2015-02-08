require 'spec_helper'

describe "Editing todo items" do
	let!(:todo_list) { TodoList.create(title: "Groceries list", description: "Groceries to buy") }
	let!(:todo_item) { todo_list.todo_items.create(content: "Milk") }

	it "is successful with valid content" do
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end
		fill_in "Content", with: "Lots of milk"
		click_button "Save"
		expect(page).to have_content("Updated todo list item")
		todo_item.reload
		expect(todo_item.content).to eq("Lots of milk")
	end

	it "is fails with no content" do
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end
		fill_in "Content", with: ""
		click_button "Save"
		expect(page).to have_content("That didn't work")
		todo_item.reload
		expect(todo_item.content).to eq("Milk")
	end

	it "is fails if content is too short" do
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end
		fill_in "Content", with: "a"
		click_button "Save"
		expect(page).to have_content("That didn't work")
		todo_item.reload
		expect(todo_item.content).to eq("Milk")
	end

end