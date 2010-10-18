Feature: Generate new prologue app
  In order to start a new project with prologue
  As a CLI
  I want to generate a rails3 app with prologue

  @disable-bundler
  Scenario: Run prologue new my_app
    When I run "prologue new my_app"
    Then the output should contain "Building authentication"
    And the output should contain "Building roles"
    And the output should contain "Building admin"
    And the output should contain "Prologue just added like 6 hours to your life."

  @disable-bundler
  Scenario: Run prologue new my_app --no-auth
    When I run "prologue new my_app --no-auth"
    Then the output should not contain "Building authentication"
    And the output should not contain "Building roles"
    And the output should not contain "Building admin"
    And the output should contain "Prologue just added like 6 hours to your life."

  @disable-bundler
  Scenario: Run prologue new my_app --no-roles
    When I run "prologue new my_app --no-roles"
    Then the output should contain "Building authentication"
    And the output should not contain "Building roles"
    And the output should contain "Building admin"
    And the output should contain "Prologue just added like 6 hours to your life."

  @disable-bundler
  Scenario: Run prologue new my_app --no-admin
    When I run "prologue new my_app --no-admin"
    Then the output should contain "Building authentication"
    And the output should contain "Building roles"
    And the output should not contain "Building admin"
    And the output should contain "Prologue just added like 6 hours to your life."

  @disable-bundler
  Scenario: Run prologue new my_app --no-admin --no-roles
    When I run "prologue new my_app --no-admin --no-roles"
    Then the output should contain "Building authentication"
    And the output should not contain "Building roles"
    And the output should not contain "Building admin"
    And the output should contain "Prologue just added like 6 hours to your life."