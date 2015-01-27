require 'spec_helper'

describe "Creating todo lists" do
	def create_todo_list(options={})
		options[:title] ||="My todo list"
		options[:description] ||= "This is my todo list."
		
		visit "/todo_lists"
		click_link "New Todo list"

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end

	it "redirects to the todo list index page on success" do
		create_todo_list
		expect(page).to have_content("My todo list")
	end

	it "displays an error when the todo list has no title" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: ""
		
		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).to_not have_content("This is my todo list")
	end

	it "displays an error when the todo list has a title of less than three characters" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: "hi"

		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).to_not have_content("This is my todo list")
	end

	it "displays an error when the todo list has no description" do
		expect(TodoList.count).to eq(0)

		create_todo_list description: ""
		
		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).to_not have_content("My todo list")
	end

	it "displays an error when the todo list has a description of less than 5 characters" do
		expect(TodoList.count).to eq(0)

		create_todo_list description: "hey"
		
		expect(TodoList.count).to eq(0)
		expect(page).to have_content("error")

		visit "/todo_lists"
		expect(page).to_not have_content("My todo list")
	end
end