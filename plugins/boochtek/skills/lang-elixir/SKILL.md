---
name: lang-elixir
description: Elixir language conventions, tooling, and known issues. Use when working in Elixir projects — writing modules, tests, configs, or debugging Elixir-specific behavior.
---

# Elixir Development

Conventions and known issues for Elixir projects.

## Tooling

- **Formatting**: `mix format` (standard Elixir formatter)
- **Linting**: `mix credo --strict`
- **Testing**: ExUnit (`mix test`)
- **Dependency management**: Mix (`mix deps.get`)
- **Version management**: mise (Erlang + Elixir versions in `.tool-versions` or `mise.toml`)

## ExUnit

### Excluding Tests by Tag

Use `ExUnit.start(exclude: [:tag_name])` in `test/test_helper.exs`.
Include at runtime with `mix test --include tag_name`.

### Runtime Test Skipping

`ExUnit.skip/1` does **not exist** as of Elixir 1.19. To conditionally skip tests at compile time:

```elixir
@available not is_nil(System.get_env("API_KEY"))

describe "Feature" do
  @tag skip: !@available
  test "does something" do
    # ...
  end
end
```

Add `:skip` to the exclude list in `test_helper.exs`:

```elixir
ExUnit.start(exclude: [:integration, :skip])
```

### Include/Exclude Interaction

`--include` overrides `--exclude` for different tags on the same test.
A test tagged both `:integration` (included) and `:cloud` (excluded) **will run** — the include wins.
Use separate tag groups to control which tests run at different levels.

## Type Specs

### Map Types

Use `required()` syntax for map types with required keys:

```elixir
@type message :: %{
  required(:role) => String.t(),
  required(:content) => String.t()
}
```

Do **not** use struct-style `key: type` syntax for plain maps.

## OTP Conventions

### Immutable Structs

Initialize all fields in the constructor. Return new structs from update functions rather than mutating state:

```elixir
def chat(%__MODULE__{} = session, message) do
  # Returns a NEW session, doesn't mutate
  %{session | messages: session.messages ++ [new_message]}
end
```

## Known Library Issues

### ExLLM v0.8.1

- **Ollama provider bug**: `HTTPClient.post_json` returns `{:ok, body}` but the Ollama provider at `ollama.ex:133` expects `{:ok, %{status: 200, body: response}}`. Workaround: rescue `CaseClauseError` and extract content from `e.term`.
- **Model config required**: ExLLM needs `config/models/<provider>.yml` files in the project root. Without them, it raises "Unknown model" errors.
- **Alpha quality**: APIs may change before v1.0.0. Pin versions carefully.
