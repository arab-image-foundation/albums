defmodule AIFAlbumsWeb.ImageHelpers do
  use Phoenix.HTML

  @base_url "https://aif.ams3.digitaloceanspaces.com/aif-albums/"

  def album_cover_image_url(album_aifid) do
    url = "#{@base_url}#{album_aifid}/cover.jpg"
    case ping_image_url(url) do
      {:ok, url} -> url
      {:error, reason} -> reason
    end
  end

  def album_spread_image_url(album_aifid, album_spread_aifid) do
    url = "#{@base_url}#{album_aifid}/#{album_spread_aifid}.jpg"
    case ping_image_url(url) do
      {:ok, url} -> url
      {:error, reason} -> reason
    end
  end

  def ping_image_url(url) do
    url
    |> HTTPoison.get()
    |> response()
  end

  defp response({:ok, %{status_code: 200, request_url: url}}), do: {:ok, url}
  defp response({:ok, %{status_code: status_code}}), do: {:ok, generate_placeholder(status_code)}
  defp response({:error, %{reason: reason}}), do: {:error, reason}

  defp generate_placeholder(status_code) do
    "https://via.placeholder.com/300/f00/fff.png?text=#{status_code}"
  end
end
