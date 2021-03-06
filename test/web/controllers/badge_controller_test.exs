defmodule AccentTest.BadgeController do
  use Accent.ConnCase, async: false

  import Mock

  alias Accent.{
    Repo,
    Project
  }

  defp behave_like_valid_response(response) do
    assert response.status == 200
    assert response.resp_body == "<svg></svg>"
    assert get_resp_header(response, "content-type") == ["image/svg+xml; charset=utf-8"]
  end

  setup do
    id = Ecto.UUID.generate()
    project = %Project{id: id, name: "project"} |> Repo.insert!()
    badge_generate_mock = [generate: fn _, _ -> {:ok, "<svg></svg>"} end]

    {:ok, %{project: project, badge_generate_mock: badge_generate_mock}}
  end

  test "percentage_reviewed_count", %{conn: conn, project: project, badge_generate_mock: badge_generate_mock} do
    with_mock Accent.BadgeGenerator, badge_generate_mock do
      response =
        conn
        |> get(badge_path(conn, :percentage_reviewed_count, project))

      behave_like_valid_response(response)
    end
  end

  test "translations_count", %{conn: conn, project: project, badge_generate_mock: badge_generate_mock} do
    with_mock Accent.BadgeGenerator, badge_generate_mock do
      response =
        conn
        |> get(badge_path(conn, :translations_count, project))

      behave_like_valid_response(response)
    end
  end

  test "reviewed_count", %{conn: conn, project: project, badge_generate_mock: badge_generate_mock} do
    with_mock Accent.BadgeGenerator, badge_generate_mock do
      response =
        conn
        |> get(badge_path(conn, :reviewed_count, project))

      behave_like_valid_response(response)
    end
  end

  test "conflicts", %{conn: conn, project: project, badge_generate_mock: badge_generate_mock} do
    with_mock Accent.BadgeGenerator, badge_generate_mock do
      response =
        conn
        |> get(badge_path(conn, :conflicts_count, project))

      behave_like_valid_response(response)
    end
  end
end
