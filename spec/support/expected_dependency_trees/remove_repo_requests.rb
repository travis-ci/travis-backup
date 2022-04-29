class ExpectedDependencyTrees
  def self.remove_repo_requests
    {
      "_": "id 1, present",
      "build": [
        {
          "_": "id 1, removed",
          "job": [
            "id 2, removed"
          ],
          "repository": [
            "id 3, present",
            "id 2, present"
          ],
          "tag": [
            "id 1, present"
          ],
          "branch": [
            "id 1, present"
          ],
          "stage": [
            "id 1, removed"
          ]
        },
        "id 3, removed",
        {
          "_": "id 6, present",
          "job": [
            "id 7, present"
          ],
          "repository": [
            "id 5, present",
            "id 4, present"
          ],
          "tag": [
            "id 2, present"
          ],
          "branch": [
            "id 2, present"
          ],
          "stage": [
            "id 2, present"
          ]
        },
        "id 8, present",
        {
          "_": "id 11, present",
          "job": [
            "id 12, present"
          ],
          "repository": [
            "id 7, present",
            "id 6, present"
          ],
          "tag": [
            "id 3, present"
          ],
          "branch": [
            "id 3, present"
          ],
          "stage": [
            "id 3, present"
          ]
        },
        "id 13, present",
        {
          "_": "id 14, removed",
          "job": [
            "id 15, removed"
          ],
          "repository": [
            "id 9, present",
            "id 8, present"
          ],
          "tag": [
            "id 4, present"
          ],
          "branch": [
            "id 4, present"
          ],
          "stage": [
            "id 4, removed"
          ]
        },
        "id 16, removed",
        {
          "_": "id 21, removed",
          "job": [
            "id 22, removed"
          ],
          "repository": [
            "id 11, present",
            "id 10, present"
          ],
          "tag": [
            "id 5, present"
          ],
          "branch": [
            "id 5, present"
          ],
          "stage": [
            "id 5, removed"
          ]
        },
        "id 23, removed"
      ],
      "request": [
        {
          "_": "id 1, removed",
          "abuse": [
            "id 1, removed",
            "id 2, removed"
          ],
          "message": [
            "id 1, removed",
            "id 2, removed"
          ],
          "job": [
            {
              "_": "id 4, removed",
              "queueable_job": [
                "id 1, removed",
                "id 2, removed"
              ],
              "job_version": [
                "id 1, removed",
                "id 2, removed"
              ]
            },
            "id 5, removed"
          ],
          "build": [
            "id 1, removed, duplicate",
            "id 3, removed, duplicate"
          ],
          "request_payload": [
            "id 1, removed",
            "id 2, removed"
          ],
          "request_raw_configuration": [
            "id 1, removed",
            "id 2, removed"
          ],
          "deleted_job": [
            "id 1, removed",
            "id 2, removed"
          ],
          "deleted_build": [
            "id 1, removed",
            "id 2, removed"
          ],
          "deleted_request_payload": [
            "id 1, removed",
            "id 2, removed"
          ],
          "deleted_request_raw_configuration": [
            "id 1, removed",
            "id 2, removed"
          ]
        },
        "id 2, removed",
        {
          "_": "id 3, present",
          "abuse": [
            "id 3, present",
            "id 4, present"
          ],
          "message": [
            "id 3, present",
            "id 4, present"
          ],
          "job": [
            {
              "_": "id 9, present",
              "queueable_job": [
                "id 3, present",
                "id 4, present"
              ],
              "job_version": [
                "id 3, present",
                "id 4, present"
              ]
            },
            "id 10, present"
          ],
          "build": [
            "id 6, present, duplicate",
            "id 8, present, duplicate"
          ],
          "request_payload": [
            "id 3, present",
            "id 4, present"
          ],
          "request_raw_configuration": [
            "id 3, present",
            "id 4, present"
          ],
          "deleted_job": [
            "id 3, present",
            "id 4, present"
          ],
          "deleted_build": [
            "id 3, present",
            "id 4, present"
          ],
          "deleted_request_payload": [
            "id 3, present",
            "id 4, present"
          ],
          "deleted_request_raw_configuration": [
            "id 3, present",
            "id 4, present"
          ]
        },
        "id 4, present",
        {
          "_": "id 5, removed",
          "abuse": [
            "id 5, removed",
            "id 6, removed"
          ],
          "message": [
            "id 5, removed",
            "id 6, removed"
          ],
          "job": [
            {
              "_": "id 17, removed",
              "queueable_job": [
                "id 5, removed",
                "id 6, removed"
              ],
              "job_version": [
                "id 5, removed",
                "id 6, removed"
              ]
            },
            "id 18, removed"
          ],
          "build": [
            "id 14, removed, duplicate",
            "id 16, removed, duplicate"
          ],
          "request_payload": [
            "id 5, removed",
            "id 6, removed"
          ],
          "request_raw_configuration": [
            "id 5, removed",
            "id 6, removed"
          ],
          "deleted_job": [
            "id 5, removed",
            "id 6, removed"
          ],
          "deleted_build": [
            "id 7, removed",
            "id 8, removed"
          ],
          "deleted_request_payload": [
            "id 5, removed",
            "id 6, removed"
          ],
          "deleted_request_raw_configuration": [
            "id 5, removed",
            "id 6, removed"
          ]
        },
        "id 6, removed",
        {
          "_": "id 7, removed",
          "abuse": [
            "id 7, removed",
            "id 8, removed"
          ],
          "message": [
            "id 7, removed",
            "id 8, removed"
          ],
          "job": [
            {
              "_": "id 24, removed",
              "queueable_job": [
                "id 9, removed",
                "id 10, removed"
              ],
              "job_version": [
                "id 9, removed",
                "id 10, removed"
              ]
            },
            "id 25, removed"
          ],
          "build": [
            "id 21, removed, duplicate",
            "id 23, removed, duplicate"
          ],
          "request_payload": [
            "id 7, removed",
            "id 8, removed"
          ],
          "request_raw_configuration": [
            "id 7, removed",
            "id 8, removed"
          ],
          "deleted_job": [
            "id 9, removed",
            "id 10, removed"
          ],
          "deleted_build": [
            "id 9, removed",
            "id 10, removed"
          ],
          "deleted_request_payload": [
            "id 7, removed",
            "id 8, removed"
          ],
          "deleted_request_raw_configuration": [
            "id 7, removed",
            "id 8, removed"
          ]
        },
        "id 8, removed"
      ],
      "job": [
        {
          "_": "id 19, present",
          "queueable_job": [
            "id 7, present",
            "id 8, present"
          ],
          "job_version": [
            "id 7, present",
            "id 8, present"
          ]
        },
        "id 20, present"
      ],
      "build_config": [
        {
          "_": "id 1, present",
          "build": [
            "id 11, present, duplicate",
            "id 13, present, duplicate"
          ],
          "deleted_build": [
            "id 5, present",
            "id 6, present"
          ]
        },
        "id 2, present"
      ],
      "request_config": [
        {
          "_": "id 1, removed",
          "request": [
            "id 5, removed, duplicate",
            "id 6, removed, duplicate"
          ],
          "deleted_request": [
            "id 1, present",
            "id 2, present"
          ]
        },
        "id 2, present"
      ],
      "job_config": [
        {
          "_": "id 1, present",
          "job": [
            "id 19, present, duplicate",
            "id 20, present, duplicate"
          ],
          "deleted_job": [
            "id 7, present",
            "id 8, present"
          ]
        },
        "id 2, present"
      ],
      "request_raw_config": [
        {
          "_": "id 1, present",
          "request_raw_configuration": [
            "id 9, present",
            "id 10, present"
          ],
          "deleted_request_raw_configuration": [
            "id 9, present",
            "id 10, present"
          ]
        },
        "id 2, present"
      ],
      "request_yaml_config": [
        {
          "_": "id 1, removed",
          "request": [
            "id 7, removed, duplicate",
            "id 8, removed, duplicate"
          ],
          "deleted_request": [
            "id 3, present",
            "id 4, present"
          ]
        },
        "id 2, present"
      ]
    }
  end
end