def test_healthcheck(test_app):
    # Given
    # When
    response = test_app.get("/health")

    # Then
    assert response.status_code == 200


def test_get_task_by_title(test_app):
    # Given
    test_data = {"title": "Homework", "description": "Learn for Math test"}

    # When
    response = test_app.get(f"api/task/{test_data['title']}")

    # Then
    assert response.status_code == 200
    task = response.json()
    assert task["title"] == "Homework"
    assert task["description"] == "Learn for Math test"
