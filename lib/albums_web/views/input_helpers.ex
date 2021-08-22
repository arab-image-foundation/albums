defmodule AlbumsWeb.InputHelpers do
  use Phoenix.HTML

  # based on http://blog.plataformatec.com.br/2016/09/dynamic-forms-with-phoenix/
  #
  # opts:
  #   using:
  #     Defaults to :text_input.
  #     Should work with most, if not all of the Phoenix.HTML.Forms functions:
  #       https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html#content
  #     Known to work with:
  #       :email_input
  #       :password_input
  #       :url_input
  #
  #   label:
  #     Defaults to humanized version of field name.
  #     Can be provided as string to override.
  #
  #   group_class:
  #     class(es) to append to the "form-group" div
  #
  #   input_opts:
  #     list of options to apply to the



  def input(form, field, opts \\ []) do
    type = opts[:using] || :text_input
    label = opts[:label] || nil
    group_class = opts[:group_class] || ""
    input_opts = opts[:input_opts] || []
    floating_label =
      case opts[:floating] do
        true -> "form-floating"
        _ -> ""
      end

    wrapper_opts = [class: "#{floating_label} #{group_class}"]
    input_class = [class: "form-control #{state_class(form, field)} #{input_opts[:class]}"]
    validations = Phoenix.HTML.Form.input_validations(form, field)
    input_opts = Keyword.merge(validations, input_opts) |> Keyword.merge(input_class)

    content_tag(:div, wrapper_opts) do
      label = label(form, field, label || humanize(field), class: "form-label")
      error = AlbumsWeb.ErrorHelpers.error_tag(form, field)
      input = input(type, form, field, input_opts)

      case opts[:floating] do
        true -> [input, label, error]
        _ -> [label, input, error]
      end
    end
  end

  defp state_class(form, field) do
    cond do
      !form.source.action -> ""
      form.errors[field] -> "is-invalid"
      true -> "is-valid"
    end
  end

  # Implement clauses below for custom inputs.
  # defp input(:datepicker, form, field, input_opts) do
  #   raise "not yet implemented"
  # end

  defp input(type, form, field, input_opts) do
    apply(Phoenix.HTML.Form, type, [form, field, input_opts])
  end
end
