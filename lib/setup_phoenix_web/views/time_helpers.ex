defmodule SetupPhoenixWeb.TimeHelpers do
  @moduledoc """
    Helper module to provide central functions to format time
  """

  def format_datetime(datetime, format \\ "%d.%m.%Y %H:%M") do
    Timex.format!(datetime, format, :strftime)
  end

end
