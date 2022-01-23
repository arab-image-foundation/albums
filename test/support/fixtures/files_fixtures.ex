defmodule AIFAlbums.FilesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AIFAlbums.Files` context.
  """

  @doc """
  Generate a csv.
  """
  def csv_fixture(attrs \\ %{}) do
    {:ok, csv} =
      attrs
      |> Enum.into(%{

      })
      |> AIFAlbums.Files.create_csv()

    csv
  end
end
