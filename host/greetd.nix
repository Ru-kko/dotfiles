{ pkgs, ... }:
{
  users.users.greeter = {
    isNormalUser = true;
  };
}