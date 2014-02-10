# Coder Night #2 Submission

This Ruby app responds to the Arlington Ruby challenge (http://www.meetup.com/Arlington-Ruby/events/160526502/).

## Operation

Standing in project root, with Ruby 1.9.3 or later and gem bundler installed:

```bash
bundle install
```

Standing in project root/lib, after modifying integration tests (at the bottom of core.rb) to execute different boards or moves.

```bash
ruby core.rb
```

## Approach

The board position is stored in a set of nested hashes.

For each row in the moves file, the application first checks that the movement is consistent with an empty board. If that validation succeeds, the move is validated for:

- intervening pieces
- exposing the King to a check
