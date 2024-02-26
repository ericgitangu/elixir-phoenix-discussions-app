# Elixir Phoenix Discussions App

## Description

This is an Elixir Phoenix application for discussions.

## Folder Structure

- `conf`: Contains configuration files for the app.
- `lib`: Contains source code files for the application logic.
- `priv`: Contains private application files (e.g., assets, templates).
- `test`: Contains test files for the application.

## Installation

To set up and run this application, you need to follow these steps:

1. Clone the repository: `git clone https:/github.com/ericgitangu/elixir-phoenix-discussions-app`
2. Install dependencies: `mix deps.get`
3. Create and migrate the database: `mix ecto.setup`
4. Start the Phoenix server: `mix phx.server`

## Usage

To use the application, follow these steps:

1. Access the application at `http://https://elixir-phoenix-discuss.fly.dev/:4000`
2. Sign up or log in with Github to start viewing and participating in discussions - Topics, comments.

## Examples

### Creating a Discussion

elixir iex> discussion = %Discussion{title: "New discussion", body: "This is a new discussion"} iex> {:ok, _} = Discussions.create_discussion(discussion)

### Adding a Comment to a Discussion

elixir iex> discussion_id = 1 iex> comment = %Comment{body: "This is a comment"} iex> {:ok,_} = Discussions.add_comment(discussion_id, comment)

## Contributing

Contributions are welcome! To contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch: `git checkout -b feature/branch-name`
3. Make your changes and commit them: `git commit -am 'Add some feature'`
4. Push the changes to your fork: `git push origin feature/branch-name`
5. Submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE)
