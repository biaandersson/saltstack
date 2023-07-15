base:
  '*':
    - namespace_grain

# will match all minions in the 'foo' namespace
  'namespace:foo':
    - foo_formula
    - bar_formula
    - foo_state
    - bar_state
