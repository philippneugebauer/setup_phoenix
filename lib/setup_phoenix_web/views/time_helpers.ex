defmodule SetupPhoenixWeb.TimeHelpers do

  def format_datetime(datetime, format \\ "%d.%m.%Y %H:%M") do
    Timex.format!(datetime, format, :strftime)
  end

end
