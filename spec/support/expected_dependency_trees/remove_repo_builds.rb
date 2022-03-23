class ExpectedDependencyTrees
  def self.remove_repo_builds
    {
      "_": "id 1, present",
      "build": [
        {
          "_": "id 1, removed",
          "job": [
            {
              "_": "id 6, removed",
              "queueable_job": [
                "id 1, removed",
                "id 2, removed"
              ],
              "job_version": [
                "id 1, removed",
                "id 2, removed"
              ]
            },
            "id 7, removed",
            "id 8, removed"
          ],
          "repository": [
            {
              "_": "id 20, present",
              "build": [
                "id 49, present"
              ],
              "request": [
                "id 10, present"
              ],
              "job": [
                "id 50, present"
              ],
              "branch": [
                "id 12, present"
              ],
              "ssl_key": [
                "id 2, present"
              ],
              "commit": [
                "id 6, present"
              ],
              "permission": [
                "id 2, present"
              ],
              "star": [
                "id 2, present"
              ],
              "pull_request": [
                "id 2, present"
              ],
              "tag": [
                "id 12, present"
              ]
            },
            "id 21, present",
            {
              "_": "id 18, present",
              "build": [
                "id 47, present"
              ],
              "request": [
                "id 9, present"
              ],
              "job": [
                "id 48, present"
              ],
              "branch": [
                "id 11, present"
              ],
              "ssl_key": [
                "id 1, present"
              ],
              "commit": [
                "id 5, present"
              ],
              "permission": [
                "id 1, present"
              ],
              "star": [
                "id 1, present"
              ],
              "pull_request": [
                "id 1, present"
              ],
              "tag": [
                "id 11, present"
              ]
            },
            "id 19, present"
          ],
          "tag": [
            {
              "_": "id 1, present",
              "build": [
                {
                  "_": "id 9, present",
                  "job": [
                    "id 10, present"
                  ],
                  "repository": [
                    "id 3, present",
                    "id 2, present"
                  ],
                  "tag": [
                    "id 2, present"
                  ],
                  "branch": [
                    "id 1, present"
                  ],
                  "stage": [
                    "id 4, present"
                  ]
                },
                "id 11, present"
              ],
              "commit": [
                {
                  "_": "id 1, present",
                  "build": [
                    {
                      "_": "id 12, present",
                      "job": [
                        "id 13, present"
                      ],
                      "repository": [
                        "id 5, present",
                        "id 4, present"
                      ],
                      "tag": [
                        "id 3, present"
                      ],
                      "branch": [
                        "id 2, present"
                      ],
                      "stage": [
                        "id 5, present"
                      ]
                    },
                    "id 14, present"
                  ],
                  "job": [
                    {
                      "_": "id 15, present",
                      "queueable_job": [
                        "id 3, present",
                        "id 4, present"
                      ],
                      "job_version": [
                        "id 3, present",
                        "id 4, present"
                      ]
                    },
                    "id 16, present"
                  ],
                  "request": [
                    {
                      "_": "id 1, present",
                      "abuse": [
                        "id 1, present",
                        "id 2, present"
                      ],
                      "message": [
                        "id 1, present",
                        "id 2, present"
                      ],
                      "job": [
                        {
                          "_": "id 20, present",
                          "queueable_job": [
                            "id 5, present",
                            "id 6, present"
                          ],
                          "job_version": [
                            "id 5, present",
                            "id 6, present"
                          ]
                        },
                        "id 21, present"
                      ],
                      "build": [
                        {
                          "_": "id 17, present",
                          "job": [
                            "id 18, present"
                          ],
                          "repository": [
                            "id 7, present",
                            "id 6, present"
                          ],
                          "tag": [
                            "id 4, present"
                          ],
                          "branch": [
                            "id 3, present"
                          ],
                          "stage": [
                            "id 6, present"
                          ]
                        },
                        "id 19, present"
                      ],
                      "request_payload": [
                        "id 1, present",
                        "id 2, present"
                      ],
                      "request_raw_configuration": [
                        "id 1, present",
                        "id 2, present"
                      ],
                      "deleted_job": [
                        "id 361, present",
                        "id 362, present"
                      ],
                      "deleted_build": [
                        "id 397, present",
                        "id 398, present"
                      ],
                      "deleted_request_payload": [
                        "id 205, present",
                        "id 206, present"
                      ],
                      "deleted_request_raw_configuration": [
                        "id 217, present",
                        "id 218, present"
                      ]
                    },
                    "id 2, present"
                  ],
                  "deleted_build": [
                    "id 399, present",
                    "id 400, present"
                  ],
                  "deleted_job": [
                    "id 363, present",
                    "id 364, present"
                  ],
                  "deleted_request": [
                    "id 205, present",
                    "id 206, present"
                  ]
                },
                "id 2, present"
              ],
              "request": [
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
                      "_": "id 25, present",
                      "queueable_job": [
                        "id 7, present",
                        "id 8, present"
                      ],
                      "job_version": [
                        "id 7, present",
                        "id 8, present"
                      ]
                    },
                    "id 26, present"
                  ],
                  "build": [
                    {
                      "_": "id 22, present",
                      "job": [
                        "id 23, present"
                      ],
                      "repository": [
                        "id 9, present",
                        "id 8, present"
                      ],
                      "tag": [
                        "id 5, present"
                      ],
                      "branch": [
                        "id 4, present"
                      ],
                      "stage": [
                        "id 7, present"
                      ]
                    },
                    "id 24, present"
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
                    "id 365, present",
                    "id 366, present"
                  ],
                  "deleted_build": [
                    "id 401, present",
                    "id 402, present"
                  ],
                  "deleted_request_payload": [
                    "id 207, present",
                    "id 208, present"
                  ],
                  "deleted_request_raw_configuration": [
                    "id 219, present",
                    "id 220, present"
                  ]
                },
                "id 4, present"
              ],
              "deleted_build": [
                "id 403, present",
                "id 404, present"
              ],
              "deleted_commit": [
                "id 85, present",
                "id 86, present"
              ],
              "deleted_request": [
                "id 207, present",
                "id 208, present"
              ]
            },
            "id 6, present"
          ],
          "branch": [
            {
              "_": "id 5, present",
              "build": [
                {
                  "_": "id 27, present",
                  "job": [
                    "id 28, present"
                  ],
                  "repository": [
                    "id 11, present",
                    "id 10, present"
                  ],
                  "tag": [
                    "id 7, present"
                  ],
                  "branch": [
                    "id 6, present"
                  ],
                  "stage": [
                    "id 8, present"
                  ]
                },
                "id 29, present"
              ],
              "commit": [
                {
                  "_": "id 3, present",
                  "build": [
                    {
                      "_": "id 32, present",
                      "job": [
                        "id 33, present"
                      ],
                      "repository": [
                        "id 13, present",
                        "id 12, present"
                      ],
                      "tag": [
                        "id 8, present"
                      ],
                      "branch": [
                        "id 7, present"
                      ],
                      "stage": [
                        "id 9, present"
                      ]
                    },
                    "id 34, present"
                  ],
                  "job": [
                    {
                      "_": "id 35, present",
                      "queueable_job": [
                        "id 11, present",
                        "id 12, present"
                      ],
                      "job_version": [
                        "id 11, present",
                        "id 12, present"
                      ]
                    },
                    "id 36, present"
                  ],
                  "request": [
                    {
                      "_": "id 5, present",
                      "abuse": [
                        "id 5, present",
                        "id 6, present"
                      ],
                      "message": [
                        "id 5, present",
                        "id 6, present"
                      ],
                      "job": [
                        {
                          "_": "id 40, present",
                          "queueable_job": [
                            "id 13, present",
                            "id 14, present"
                          ],
                          "job_version": [
                            "id 13, present",
                            "id 14, present"
                          ]
                        },
                        "id 41, present"
                      ],
                      "build": [
                        {
                          "_": "id 37, present",
                          "job": [
                            "id 38, present"
                          ],
                          "repository": [
                            "id 15, present",
                            "id 14, present"
                          ],
                          "tag": [
                            "id 9, present"
                          ],
                          "branch": [
                            "id 8, present"
                          ],
                          "stage": [
                            "id 10, present"
                          ]
                        },
                        "id 39, present"
                      ],
                      "request_payload": [
                        "id 5, present",
                        "id 6, present"
                      ],
                      "request_raw_configuration": [
                        "id 5, present",
                        "id 6, present"
                      ],
                      "deleted_job": [
                        "id 369, present",
                        "id 370, present"
                      ],
                      "deleted_build": [
                        "id 407, present",
                        "id 408, present"
                      ],
                      "deleted_request_payload": [
                        "id 209, present",
                        "id 210, present"
                      ],
                      "deleted_request_raw_configuration": [
                        "id 221, present",
                        "id 222, present"
                      ]
                    },
                    "id 6, present"
                  ],
                  "deleted_build": [
                    "id 409, present",
                    "id 410, present"
                  ],
                  "deleted_job": [
                    "id 371, present",
                    "id 372, present"
                  ],
                  "deleted_request": [
                    "id 209, present",
                    "id 210, present"
                  ]
                },
                "id 4, present"
              ],
              "cron": [
                "id 1, present"
              ],
              "job": [
                {
                  "_": "id 30, present",
                  "queueable_job": [
                    "id 9, present",
                    "id 10, present"
                  ],
                  "job_version": [
                    "id 9, present",
                    "id 10, present"
                  ]
                },
                "id 31, present"
              ],
              "request": [
                {
                  "_": "id 7, present",
                  "abuse": [
                    "id 7, present",
                    "id 8, present"
                  ],
                  "message": [
                    "id 7, present",
                    "id 8, present"
                  ],
                  "job": [
                    {
                      "_": "id 45, present",
                      "queueable_job": [
                        "id 15, present",
                        "id 16, present"
                      ],
                      "job_version": [
                        "id 15, present",
                        "id 16, present"
                      ]
                    },
                    "id 46, present"
                  ],
                  "build": [
                    {
                      "_": "id 42, present",
                      "job": [
                        "id 43, present"
                      ],
                      "repository": [
                        "id 17, present",
                        "id 16, present"
                      ],
                      "tag": [
                        "id 10, present"
                      ],
                      "branch": [
                        "id 9, present"
                      ],
                      "stage": [
                        "id 11, present"
                      ]
                    },
                    "id 44, present"
                  ],
                  "request_payload": [
                    "id 7, present",
                    "id 8, present"
                  ],
                  "request_raw_configuration": [
                    "id 7, present",
                    "id 8, present"
                  ],
                  "deleted_job": [
                    "id 373, present",
                    "id 374, present"
                  ],
                  "deleted_build": [
                    "id 411, present",
                    "id 412, present"
                  ],
                  "deleted_request_payload": [
                    "id 211, present",
                    "id 212, present"
                  ],
                  "deleted_request_raw_configuration": [
                    "id 223, present",
                    "id 224, present"
                  ]
                },
                "id 8, present"
              ],
              "deleted_build": [
                "id 405, present",
                "id 406, present"
              ],
              "deleted_commit": [
                "id 87, present",
                "id 88, present"
              ],
              "deleted_job": [
                "id 367, present",
                "id 368, present"
              ],
              "deleted_request": [
                "id 211, present",
                "id 212, present"
              ]
            },
            "id 10, present"
          ],
          "stage": [
            {
              "_": "id 1, removed",
              "job": [
                "id 2, removed",
                "id 3, removed"
              ]
            },
            {
              "_": "id 2, removed",
              "job": [
                "id 4, removed",
                "id 5, removed"
              ]
            },
            "id 3, removed"
          ],
          "deleted_job": [
            "id 375, removed"
          ],
          "deleted_tag": [
            "id 25, present"
          ],
          "deleted_stage": [
            "id 13, removed"
          ]
        },
        "id 51, removed",
        {
          "_": "id 178, removed",
          "job": [
            {
              "_": "id 183, removed",
              "queueable_job": [
                "id 63, removed",
                "id 64, removed"
              ],
              "job_version": [
                "id 63, removed",
                "id 64, removed"
              ]
            },
            "id 184, removed"
          ],
          "stage": [
            {
              "_": "id 38, removed",
              "job": [
                "id 179, removed",
                "id 180, removed"
              ]
            },
            {
              "_": "id 39, removed",
              "job": [
                "id 181, removed",
                "id 182, removed"
              ]
            }
          ]
        },
        {
          "_": "id 185, present",
          "job": [
            {
              "_": "id 190, present",
              "queueable_job": [
                "id 65, present",
                "id 66, present"
              ],
              "job_version": [
                "id 65, present",
                "id 66, present"
              ]
            },
            "id 191, present"
          ],
          "stage": [
            {
              "_": "id 40, present",
              "job": [
                "id 186, present",
                "id 187, present"
              ]
            },
            {
              "_": "id 41, present",
              "job": [
                "id 188, present",
                "id 189, present"
              ]
            }
          ]
        },
        {
          "_": "id 192, removed",
          "job": [
            {
              "_": "id 197, removed",
              "queueable_job": [
                "id 67, removed",
                "id 68, removed"
              ],
              "job_version": [
                "id 67, removed",
                "id 68, removed"
              ]
            },
            "id 198, removed"
          ],
          "repository": [
            "id 1, present, duplicate"
          ],
          "stage": [
            {
              "_": "id 42, removed",
              "job": [
                "id 193, removed",
                "id 194, removed"
              ]
            },
            {
              "_": "id 43, removed",
              "job": [
                "id 195, removed",
                "id 196, removed"
              ]
            }
          ]
        }
      ],
      "request": [
        {
          "_": "id 11, present",
          "abuse": [
            "id 9, present",
            "id 10, present"
          ],
          "message": [
            "id 9, present",
            "id 10, present"
          ],
          "job": [
            {
              "_": "id 55, present",
              "queueable_job": [
                "id 17, present",
                "id 18, present"
              ],
              "job_version": [
                "id 17, present",
                "id 18, present"
              ]
            },
            "id 56, present"
          ],
          "build": [
            {
              "_": "id 52, present",
              "job": [
                "id 53, present"
              ],
              "repository": [
                "id 23, present",
                "id 22, present"
              ],
              "tag": [
                "id 13, present"
              ],
              "branch": [
                "id 13, present"
              ],
              "stage": [
                "id 12, present"
              ]
            },
            "id 54, present"
          ],
          "request_payload": [
            "id 9, present",
            "id 10, present"
          ],
          "request_raw_configuration": [
            "id 9, present",
            "id 10, present"
          ],
          "deleted_job": [
            "id 376, present",
            "id 377, present"
          ],
          "deleted_build": [
            "id 413, present",
            "id 414, present"
          ],
          "deleted_request_payload": [
            "id 213, present",
            "id 214, present"
          ],
          "deleted_request_raw_configuration": [
            "id 225, present",
            "id 226, present"
          ]
        },
        "id 12, present",
        "id 39, present",
        "id 40, present"
      ],
      "job": [
        {
          "_": "id 57, present",
          "queueable_job": [
            "id 19, present",
            "id 20, present"
          ],
          "job_version": [
            "id 19, present",
            "id 20, present"
          ]
        },
        "id 58, present"
      ],
      "branch": [
        {
          "_": "id 14, present",
          "build": [
            {
              "_": "id 59, present",
              "job": [
                "id 60, present"
              ],
              "repository": [
                "id 25, present",
                "id 24, present"
              ],
              "tag": [
                "id 14, present"
              ],
              "branch": [
                "id 15, present"
              ],
              "stage": [
                "id 13, present"
              ]
            },
            "id 61, present"
          ],
          "commit": [
            {
              "_": "id 7, present",
              "build": [
                {
                  "_": "id 64, present",
                  "job": [
                    "id 65, present"
                  ],
                  "repository": [
                    "id 27, present",
                    "id 26, present"
                  ],
                  "tag": [
                    "id 15, present"
                  ],
                  "branch": [
                    "id 16, present"
                  ],
                  "stage": [
                    "id 14, present"
                  ]
                },
                "id 66, present"
              ],
              "job": [
                {
                  "_": "id 67, present",
                  "queueable_job": [
                    "id 23, present",
                    "id 24, present"
                  ],
                  "job_version": [
                    "id 23, present",
                    "id 24, present"
                  ]
                },
                "id 68, present"
              ],
              "request": [
                {
                  "_": "id 13, present",
                  "abuse": [
                    "id 11, present",
                    "id 12, present"
                  ],
                  "message": [
                    "id 11, present",
                    "id 12, present"
                  ],
                  "job": [
                    {
                      "_": "id 72, present",
                      "queueable_job": [
                        "id 25, present",
                        "id 26, present"
                      ],
                      "job_version": [
                        "id 25, present",
                        "id 26, present"
                      ]
                    },
                    "id 73, present"
                  ],
                  "build": [
                    {
                      "_": "id 69, present",
                      "job": [
                        "id 70, present"
                      ],
                      "repository": [
                        "id 29, present",
                        "id 28, present"
                      ],
                      "tag": [
                        "id 16, present"
                      ],
                      "branch": [
                        "id 17, present"
                      ],
                      "stage": [
                        "id 15, present"
                      ]
                    },
                    "id 71, present"
                  ],
                  "request_payload": [
                    "id 11, present",
                    "id 12, present"
                  ],
                  "request_raw_configuration": [
                    "id 11, present",
                    "id 12, present"
                  ],
                  "deleted_job": [
                    "id 380, present",
                    "id 381, present"
                  ],
                  "deleted_build": [
                    "id 417, present",
                    "id 418, present"
                  ],
                  "deleted_request_payload": [
                    "id 215, present",
                    "id 216, present"
                  ],
                  "deleted_request_raw_configuration": [
                    "id 227, present",
                    "id 228, present"
                  ]
                },
                "id 14, present"
              ],
              "deleted_build": [
                "id 419, present",
                "id 420, present"
              ],
              "deleted_job": [
                "id 382, present",
                "id 383, present"
              ],
              "deleted_request": [
                "id 213, present",
                "id 214, present"
              ]
            },
            "id 8, present"
          ],
          "cron": [
            "id 2, present"
          ],
          "job": [
            {
              "_": "id 62, present",
              "queueable_job": [
                "id 21, present",
                "id 22, present"
              ],
              "job_version": [
                "id 21, present",
                "id 22, present"
              ]
            },
            "id 63, present"
          ],
          "request": [
            {
              "_": "id 15, present",
              "abuse": [
                "id 13, present",
                "id 14, present"
              ],
              "message": [
                "id 13, present",
                "id 14, present"
              ],
              "job": [
                {
                  "_": "id 77, present",
                  "queueable_job": [
                    "id 27, present",
                    "id 28, present"
                  ],
                  "job_version": [
                    "id 27, present",
                    "id 28, present"
                  ]
                },
                "id 78, present"
              ],
              "build": [
                {
                  "_": "id 74, present",
                  "job": [
                    "id 75, present"
                  ],
                  "repository": [
                    "id 31, present",
                    "id 30, present"
                  ],
                  "tag": [
                    "id 17, present"
                  ],
                  "branch": [
                    "id 18, present"
                  ],
                  "stage": [
                    "id 16, present"
                  ]
                },
                "id 76, present"
              ],
              "request_payload": [
                "id 13, present",
                "id 14, present"
              ],
              "request_raw_configuration": [
                "id 13, present",
                "id 14, present"
              ],
              "deleted_job": [
                "id 384, present",
                "id 385, present"
              ],
              "deleted_build": [
                "id 421, present",
                "id 422, present"
              ],
              "deleted_request_payload": [
                "id 217, present",
                "id 218, present"
              ],
              "deleted_request_raw_configuration": [
                "id 229, present",
                "id 230, present"
              ]
            },
            "id 16, present"
          ],
          "deleted_build": [
            "id 415, present",
            "id 416, present"
          ],
          "deleted_commit": [
            "id 89, present",
            "id 90, present"
          ],
          "deleted_job": [
            "id 378, present",
            "id 379, present"
          ],
          "deleted_request": [
            "id 215, present",
            "id 216, present"
          ]
        },
        "id 19, present"
      ],
      "ssl_key": [
        "id 3, present",
        "id 4, present"
      ],
      "commit": [
        {
          "_": "id 9, present",
          "build": [
            {
              "_": "id 79, present",
              "job": [
                "id 80, present"
              ],
              "repository": [
                "id 33, present",
                "id 32, present"
              ],
              "tag": [
                "id 18, present"
              ],
              "branch": [
                "id 20, present"
              ],
              "stage": [
                "id 17, present"
              ]
            },
            "id 81, present"
          ],
          "job": [
            {
              "_": "id 82, present",
              "queueable_job": [
                "id 29, present",
                "id 30, present"
              ],
              "job_version": [
                "id 29, present",
                "id 30, present"
              ]
            },
            "id 83, present"
          ],
          "request": [
            {
              "_": "id 17, present",
              "abuse": [
                "id 15, present",
                "id 16, present"
              ],
              "message": [
                "id 15, present",
                "id 16, present"
              ],
              "job": [
                {
                  "_": "id 87, present",
                  "queueable_job": [
                    "id 31, present",
                    "id 32, present"
                  ],
                  "job_version": [
                    "id 31, present",
                    "id 32, present"
                  ]
                },
                "id 88, present"
              ],
              "build": [
                {
                  "_": "id 84, present",
                  "job": [
                    "id 85, present"
                  ],
                  "repository": [
                    "id 35, present",
                    "id 34, present"
                  ],
                  "tag": [
                    "id 19, present"
                  ],
                  "branch": [
                    "id 21, present"
                  ],
                  "stage": [
                    "id 18, present"
                  ]
                },
                "id 86, present"
              ],
              "request_payload": [
                "id 15, present",
                "id 16, present"
              ],
              "request_raw_configuration": [
                "id 15, present",
                "id 16, present"
              ],
              "deleted_job": [
                "id 386, present",
                "id 387, present"
              ],
              "deleted_build": [
                "id 423, present",
                "id 424, present"
              ],
              "deleted_request_payload": [
                "id 219, present",
                "id 220, present"
              ],
              "deleted_request_raw_configuration": [
                "id 231, present",
                "id 232, present"
              ]
            },
            "id 18, present"
          ],
          "deleted_build": [
            "id 425, present",
            "id 426, present"
          ],
          "deleted_job": [
            "id 388, present",
            "id 389, present"
          ],
          "deleted_request": [
            "id 217, present",
            "id 218, present"
          ]
        },
        "id 10, present"
      ],
      "permission": [
        "id 3, present",
        "id 4, present"
      ],
      "star": [
        "id 3, present",
        "id 4, present"
      ],
      "pull_request": [
        {
          "_": "id 3, present",
          "request": [
            {
              "_": "id 29, present",
              "abuse": [
                "id 25, present",
                "id 26, present"
              ],
              "message": [
                "id 25, present",
                "id 26, present"
              ],
              "job": [
                {
                  "_": "id 143, present",
                  "queueable_job": [
                    "id 49, present",
                    "id 50, present"
                  ],
                  "job_version": [
                    "id 49, present",
                    "id 50, present"
                  ]
                },
                "id 144, present"
              ],
              "build": [
                {
                  "_": "id 140, present",
                  "job": [
                    "id 141, present"
                  ],
                  "repository": [
                    "id 57, present",
                    "id 56, present"
                  ],
                  "tag": [
                    "id 32, present"
                  ],
                  "branch": [
                    "id 34, present"
                  ],
                  "stage": [
                    "id 30, present"
                  ]
                },
                "id 142, present"
              ],
              "request_payload": [
                "id 25, present",
                "id 26, present"
              ],
              "request_raw_configuration": [
                "id 25, present",
                "id 26, present"
              ],
              "deleted_job": [
                "id 405, present",
                "id 406, present"
              ],
              "deleted_build": [
                "id 443, present",
                "id 444, present"
              ],
              "deleted_request_payload": [
                "id 229, present",
                "id 230, present"
              ],
              "deleted_request_raw_configuration": [
                "id 241, present",
                "id 242, present"
              ]
            },
            "id 30, present"
          ],
          "build": [
            {
              "_": "id 89, present",
              "job": [
                {
                  "_": "id 94, present",
                  "queueable_job": [
                    "id 33, present",
                    "id 34, present"
                  ],
                  "job_version": [
                    "id 33, present",
                    "id 34, present"
                  ]
                },
                "id 95, present",
                "id 96, present"
              ],
              "repository": [
                {
                  "_": "id 54, present",
                  "build": [
                    "id 137, present"
                  ],
                  "request": [
                    "id 28, present"
                  ],
                  "job": [
                    "id 138, present"
                  ],
                  "branch": [
                    "id 33, present"
                  ],
                  "ssl_key": [
                    "id 6, present"
                  ],
                  "commit": [
                    "id 16, present"
                  ],
                  "permission": [
                    "id 6, present"
                  ],
                  "star": [
                    "id 6, present"
                  ],
                  "pull_request": [
                    "id 5, present"
                  ],
                  "tag": [
                    "id 31, present"
                  ]
                },
                "id 55, present",
                {
                  "_": "id 52, present",
                  "build": [
                    "id 135, present"
                  ],
                  "request": [
                    "id 27, present"
                  ],
                  "job": [
                    "id 136, present"
                  ],
                  "branch": [
                    "id 32, present"
                  ],
                  "ssl_key": [
                    "id 5, present"
                  ],
                  "commit": [
                    "id 15, present"
                  ],
                  "permission": [
                    "id 5, present"
                  ],
                  "star": [
                    "id 5, present"
                  ],
                  "pull_request": [
                    "id 4, present"
                  ],
                  "tag": [
                    "id 30, present"
                  ]
                },
                "id 53, present"
              ],
              "tag": [
                {
                  "_": "id 20, present",
                  "build": [
                    {
                      "_": "id 97, present",
                      "job": [
                        "id 98, present"
                      ],
                      "repository": [
                        "id 37, present",
                        "id 36, present"
                      ],
                      "tag": [
                        "id 21, present"
                      ],
                      "branch": [
                        "id 22, present"
                      ],
                      "stage": [
                        "id 22, present"
                      ]
                    },
                    "id 99, present"
                  ],
                  "commit": [
                    {
                      "_": "id 11, present",
                      "build": [
                        {
                          "_": "id 100, present",
                          "job": [
                            "id 101, present"
                          ],
                          "repository": [
                            "id 39, present",
                            "id 38, present"
                          ],
                          "tag": [
                            "id 22, present"
                          ],
                          "branch": [
                            "id 23, present"
                          ],
                          "stage": [
                            "id 23, present"
                          ]
                        },
                        "id 102, present"
                      ],
                      "job": [
                        {
                          "_": "id 103, present",
                          "queueable_job": [
                            "id 35, present",
                            "id 36, present"
                          ],
                          "job_version": [
                            "id 35, present",
                            "id 36, present"
                          ]
                        },
                        "id 104, present"
                      ],
                      "request": [
                        {
                          "_": "id 19, present",
                          "abuse": [
                            "id 17, present",
                            "id 18, present"
                          ],
                          "message": [
                            "id 17, present",
                            "id 18, present"
                          ],
                          "job": [
                            {
                              "_": "id 108, present",
                              "queueable_job": [
                                "id 37, present",
                                "id 38, present"
                              ],
                              "job_version": [
                                "id 37, present",
                                "id 38, present"
                              ]
                            },
                            "id 109, present"
                          ],
                          "build": [
                            {
                              "_": "id 105, present",
                              "job": [
                                "id 106, present"
                              ],
                              "repository": [
                                "id 41, present",
                                "id 40, present"
                              ],
                              "tag": [
                                "id 23, present"
                              ],
                              "branch": [
                                "id 24, present"
                              ],
                              "stage": [
                                "id 24, present"
                              ]
                            },
                            "id 107, present"
                          ],
                          "request_payload": [
                            "id 17, present",
                            "id 18, present"
                          ],
                          "request_raw_configuration": [
                            "id 17, present",
                            "id 18, present"
                          ],
                          "deleted_job": [
                            "id 390, present",
                            "id 391, present"
                          ],
                          "deleted_build": [
                            "id 427, present",
                            "id 428, present"
                          ],
                          "deleted_request_payload": [
                            "id 221, present",
                            "id 222, present"
                          ],
                          "deleted_request_raw_configuration": [
                            "id 233, present",
                            "id 234, present"
                          ]
                        },
                        "id 20, present"
                      ],
                      "deleted_build": [
                        "id 429, present",
                        "id 430, present"
                      ],
                      "deleted_job": [
                        "id 392, present",
                        "id 393, present"
                      ],
                      "deleted_request": [
                        "id 219, present",
                        "id 220, present"
                      ]
                    },
                    "id 12, present"
                  ],
                  "request": [
                    {
                      "_": "id 21, present",
                      "abuse": [
                        "id 19, present",
                        "id 20, present"
                      ],
                      "message": [
                        "id 19, present",
                        "id 20, present"
                      ],
                      "job": [
                        {
                          "_": "id 113, present",
                          "queueable_job": [
                            "id 39, present",
                            "id 40, present"
                          ],
                          "job_version": [
                            "id 39, present",
                            "id 40, present"
                          ]
                        },
                        "id 114, present"
                      ],
                      "build": [
                        {
                          "_": "id 110, present",
                          "job": [
                            "id 111, present"
                          ],
                          "repository": [
                            "id 43, present",
                            "id 42, present"
                          ],
                          "tag": [
                            "id 24, present"
                          ],
                          "branch": [
                            "id 25, present"
                          ],
                          "stage": [
                            "id 25, present"
                          ]
                        },
                        "id 112, present"
                      ],
                      "request_payload": [
                        "id 19, present",
                        "id 20, present"
                      ],
                      "request_raw_configuration": [
                        "id 19, present",
                        "id 20, present"
                      ],
                      "deleted_job": [
                        "id 394, present",
                        "id 395, present"
                      ],
                      "deleted_build": [
                        "id 431, present",
                        "id 432, present"
                      ],
                      "deleted_request_payload": [
                        "id 223, present",
                        "id 224, present"
                      ],
                      "deleted_request_raw_configuration": [
                        "id 235, present",
                        "id 236, present"
                      ]
                    },
                    "id 22, present"
                  ],
                  "deleted_build": [
                    "id 433, present",
                    "id 434, present"
                  ],
                  "deleted_commit": [
                    "id 91, present",
                    "id 92, present"
                  ],
                  "deleted_request": [
                    "id 221, present",
                    "id 222, present"
                  ]
                },
                "id 25, present"
              ],
              "branch": [
                {
                  "_": "id 26, present",
                  "build": [
                    {
                      "_": "id 115, present",
                      "job": [
                        "id 116, present"
                      ],
                      "repository": [
                        "id 45, present",
                        "id 44, present"
                      ],
                      "tag": [
                        "id 26, present"
                      ],
                      "branch": [
                        "id 27, present"
                      ],
                      "stage": [
                        "id 26, present"
                      ]
                    },
                    "id 117, present"
                  ],
                  "commit": [
                    {
                      "_": "id 13, present",
                      "build": [
                        {
                          "_": "id 120, present",
                          "job": [
                            "id 121, present"
                          ],
                          "repository": [
                            "id 47, present",
                            "id 46, present"
                          ],
                          "tag": [
                            "id 27, present"
                          ],
                          "branch": [
                            "id 28, present"
                          ],
                          "stage": [
                            "id 27, present"
                          ]
                        },
                        "id 122, present"
                      ],
                      "job": [
                        {
                          "_": "id 123, present",
                          "queueable_job": [
                            "id 43, present",
                            "id 44, present"
                          ],
                          "job_version": [
                            "id 43, present",
                            "id 44, present"
                          ]
                        },
                        "id 124, present"
                      ],
                      "request": [
                        {
                          "_": "id 23, present",
                          "abuse": [
                            "id 21, present",
                            "id 22, present"
                          ],
                          "message": [
                            "id 21, present",
                            "id 22, present"
                          ],
                          "job": [
                            {
                              "_": "id 128, present",
                              "queueable_job": [
                                "id 45, present",
                                "id 46, present"
                              ],
                              "job_version": [
                                "id 45, present",
                                "id 46, present"
                              ]
                            },
                            "id 129, present"
                          ],
                          "build": [
                            {
                              "_": "id 125, present",
                              "job": [
                                "id 126, present"
                              ],
                              "repository": [
                                "id 49, present",
                                "id 48, present"
                              ],
                              "tag": [
                                "id 28, present"
                              ],
                              "branch": [
                                "id 29, present"
                              ],
                              "stage": [
                                "id 28, present"
                              ]
                            },
                            "id 127, present"
                          ],
                          "request_payload": [
                            "id 21, present",
                            "id 22, present"
                          ],
                          "request_raw_configuration": [
                            "id 21, present",
                            "id 22, present"
                          ],
                          "deleted_job": [
                            "id 398, present",
                            "id 399, present"
                          ],
                          "deleted_build": [
                            "id 437, present",
                            "id 438, present"
                          ],
                          "deleted_request_payload": [
                            "id 225, present",
                            "id 226, present"
                          ],
                          "deleted_request_raw_configuration": [
                            "id 237, present",
                            "id 238, present"
                          ]
                        },
                        "id 24, present"
                      ],
                      "deleted_build": [
                        "id 439, present",
                        "id 440, present"
                      ],
                      "deleted_job": [
                        "id 400, present",
                        "id 401, present"
                      ],
                      "deleted_request": [
                        "id 223, present",
                        "id 224, present"
                      ]
                    },
                    "id 14, present"
                  ],
                  "cron": [
                    "id 3, present"
                  ],
                  "job": [
                    {
                      "_": "id 118, present",
                      "queueable_job": [
                        "id 41, present",
                        "id 42, present"
                      ],
                      "job_version": [
                        "id 41, present",
                        "id 42, present"
                      ]
                    },
                    "id 119, present"
                  ],
                  "request": [
                    {
                      "_": "id 25, present",
                      "abuse": [
                        "id 23, present",
                        "id 24, present"
                      ],
                      "message": [
                        "id 23, present",
                        "id 24, present"
                      ],
                      "job": [
                        {
                          "_": "id 133, present",
                          "queueable_job": [
                            "id 47, present",
                            "id 48, present"
                          ],
                          "job_version": [
                            "id 47, present",
                            "id 48, present"
                          ]
                        },
                        "id 134, present"
                      ],
                      "build": [
                        {
                          "_": "id 130, present",
                          "job": [
                            "id 131, present"
                          ],
                          "repository": [
                            "id 51, present",
                            "id 50, present"
                          ],
                          "tag": [
                            "id 29, present"
                          ],
                          "branch": [
                            "id 30, present"
                          ],
                          "stage": [
                            "id 29, present"
                          ]
                        },
                        "id 132, present"
                      ],
                      "request_payload": [
                        "id 23, present",
                        "id 24, present"
                      ],
                      "request_raw_configuration": [
                        "id 23, present",
                        "id 24, present"
                      ],
                      "deleted_job": [
                        "id 402, present",
                        "id 403, present"
                      ],
                      "deleted_build": [
                        "id 441, present",
                        "id 442, present"
                      ],
                      "deleted_request_payload": [
                        "id 227, present",
                        "id 228, present"
                      ],
                      "deleted_request_raw_configuration": [
                        "id 239, present",
                        "id 240, present"
                      ]
                    },
                    "id 26, present"
                  ],
                  "deleted_build": [
                    "id 435, present",
                    "id 436, present"
                  ],
                  "deleted_commit": [
                    "id 93, present",
                    "id 94, present"
                  ],
                  "deleted_job": [
                    "id 396, present",
                    "id 397, present"
                  ],
                  "deleted_request": [
                    "id 225, present",
                    "id 226, present"
                  ]
                },
                "id 31, present"
              ],
              "stage": [
                {
                  "_": "id 19, present",
                  "job": [
                    "id 90, present",
                    "id 91, present"
                  ]
                },
                {
                  "_": "id 20, present",
                  "job": [
                    "id 92, present",
                    "id 93, present"
                  ]
                },
                "id 21, present"
              ],
              "deleted_job": [
                "id 404, present"
              ],
              "deleted_tag": [
                "id 26, present"
              ],
              "deleted_stage": [
                "id 14, present"
              ]
            },
            "id 139, present"
          ],
          "deleted_request": [
            "id 227, present",
            "id 228, present"
          ],
          "deleted_build": [
            "id 445, present",
            "id 446, present"
          ]
        },
        "id 6, present"
      ],
      "tag": [
        {
          "_": "id 33, present",
          "build": [
            {
              "_": "id 145, present",
              "job": [
                "id 146, present"
              ],
              "repository": [
                "id 59, present",
                "id 58, present"
              ],
              "tag": [
                "id 34, present"
              ],
              "branch": [
                "id 35, present"
              ],
              "stage": [
                "id 31, present"
              ]
            },
            "id 147, present"
          ],
          "commit": [
            {
              "_": "id 17, present",
              "build": [
                {
                  "_": "id 148, present",
                  "job": [
                    "id 149, present"
                  ],
                  "repository": [
                    "id 61, present",
                    "id 60, present"
                  ],
                  "tag": [
                    "id 35, present"
                  ],
                  "branch": [
                    "id 36, present"
                  ],
                  "stage": [
                    "id 32, present"
                  ]
                },
                "id 150, present"
              ],
              "job": [
                {
                  "_": "id 151, present",
                  "queueable_job": [
                    "id 51, present",
                    "id 52, present"
                  ],
                  "job_version": [
                    "id 51, present",
                    "id 52, present"
                  ]
                },
                "id 152, present"
              ],
              "request": [
                {
                  "_": "id 31, present",
                  "abuse": [
                    "id 27, present",
                    "id 28, present"
                  ],
                  "message": [
                    "id 27, present",
                    "id 28, present"
                  ],
                  "job": [
                    {
                      "_": "id 156, present",
                      "queueable_job": [
                        "id 53, present",
                        "id 54, present"
                      ],
                      "job_version": [
                        "id 53, present",
                        "id 54, present"
                      ]
                    },
                    "id 157, present"
                  ],
                  "build": [
                    {
                      "_": "id 153, present",
                      "job": [
                        "id 154, present"
                      ],
                      "repository": [
                        "id 63, present",
                        "id 62, present"
                      ],
                      "tag": [
                        "id 36, present"
                      ],
                      "branch": [
                        "id 37, present"
                      ],
                      "stage": [
                        "id 33, present"
                      ]
                    },
                    "id 155, present"
                  ],
                  "request_payload": [
                    "id 27, present",
                    "id 28, present"
                  ],
                  "request_raw_configuration": [
                    "id 27, present",
                    "id 28, present"
                  ],
                  "deleted_job": [
                    "id 407, present",
                    "id 408, present"
                  ],
                  "deleted_build": [
                    "id 447, present",
                    "id 448, present"
                  ],
                  "deleted_request_payload": [
                    "id 231, present",
                    "id 232, present"
                  ],
                  "deleted_request_raw_configuration": [
                    "id 243, present",
                    "id 244, present"
                  ]
                },
                "id 32, present"
              ],
              "deleted_build": [
                "id 449, present",
                "id 450, present"
              ],
              "deleted_job": [
                "id 409, present",
                "id 410, present"
              ],
              "deleted_request": [
                "id 229, present",
                "id 230, present"
              ]
            },
            "id 18, present"
          ],
          "request": [
            {
              "_": "id 33, present",
              "abuse": [
                "id 29, present",
                "id 30, present"
              ],
              "message": [
                "id 29, present",
                "id 30, present"
              ],
              "job": [
                {
                  "_": "id 161, present",
                  "queueable_job": [
                    "id 55, present",
                    "id 56, present"
                  ],
                  "job_version": [
                    "id 55, present",
                    "id 56, present"
                  ]
                },
                "id 162, present"
              ],
              "build": [
                {
                  "_": "id 158, present",
                  "job": [
                    "id 159, present"
                  ],
                  "repository": [
                    "id 65, present",
                    "id 64, present"
                  ],
                  "tag": [
                    "id 37, present"
                  ],
                  "branch": [
                    "id 38, present"
                  ],
                  "stage": [
                    "id 34, present"
                  ]
                },
                "id 160, present"
              ],
              "request_payload": [
                "id 29, present",
                "id 30, present"
              ],
              "request_raw_configuration": [
                "id 29, present",
                "id 30, present"
              ],
              "deleted_job": [
                "id 411, present",
                "id 412, present"
              ],
              "deleted_build": [
                "id 451, present",
                "id 452, present"
              ],
              "deleted_request_payload": [
                "id 233, present",
                "id 234, present"
              ],
              "deleted_request_raw_configuration": [
                "id 245, present",
                "id 246, present"
              ]
            },
            "id 34, present"
          ],
          "deleted_build": [
            "id 453, present",
            "id 454, present"
          ],
          "deleted_commit": [
            "id 95, present",
            "id 96, present"
          ],
          "deleted_request": [
            "id 231, present",
            "id 232, present"
          ]
        },
        "id 38, present"
      ],
      "build_config": [
        {
          "_": "id 1, present",
          "build": [
            {
              "_": "id 163, present",
              "job": [
                "id 164, present"
              ],
              "repository": [
                "id 67, present",
                "id 66, present"
              ],
              "tag": [
                "id 39, present"
              ],
              "branch": [
                "id 39, present"
              ],
              "stage": [
                "id 35, present"
              ]
            },
            "id 165, present"
          ],
          "deleted_build": [
            "id 455, present",
            "id 456, present"
          ]
        },
        "id 2, present"
      ],
      "email_unsubscribe": [
        "id 1, present",
        "id 2, present"
      ],
      "request_config": [
        {
          "_": "id 1, present",
          "request": [
            {
              "_": "id 35, present",
              "abuse": [
                "id 31, present",
                "id 32, present"
              ],
              "message": [
                "id 31, present",
                "id 32, present"
              ],
              "job": [
                {
                  "_": "id 169, present",
                  "queueable_job": [
                    "id 57, present",
                    "id 58, present"
                  ],
                  "job_version": [
                    "id 57, present",
                    "id 58, present"
                  ]
                },
                "id 170, present"
              ],
              "build": [
                {
                  "_": "id 166, present",
                  "job": [
                    "id 167, present"
                  ],
                  "repository": [
                    "id 69, present",
                    "id 68, present"
                  ],
                  "tag": [
                    "id 40, present"
                  ],
                  "branch": [
                    "id 40, present"
                  ],
                  "stage": [
                    "id 36, present"
                  ]
                },
                "id 168, present"
              ],
              "request_payload": [
                "id 31, present",
                "id 32, present"
              ],
              "request_raw_configuration": [
                "id 31, present",
                "id 32, present"
              ],
              "deleted_job": [
                "id 413, present",
                "id 414, present"
              ],
              "deleted_build": [
                "id 457, present",
                "id 458, present"
              ],
              "deleted_request_payload": [
                "id 235, present",
                "id 236, present"
              ],
              "deleted_request_raw_configuration": [
                "id 247, present",
                "id 248, present"
              ]
            },
            "id 36, present"
          ],
          "deleted_request": [
            "id 233, present",
            "id 234, present"
          ]
        },
        "id 2, present"
      ],
      "job_config": [
        {
          "_": "id 1, present",
          "job": [
            {
              "_": "id 171, present",
              "queueable_job": [
                "id 59, present",
                "id 60, present"
              ],
              "job_version": [
                "id 59, present",
                "id 60, present"
              ]
            },
            "id 172, present"
          ],
          "deleted_job": [
            "id 415, present",
            "id 416, present"
          ]
        },
        "id 2, present"
      ],
      "request_raw_config": [
        {
          "_": "id 1, present",
          "request_raw_configuration": [
            "id 33, present",
            "id 34, present"
          ],
          "deleted_request_raw_configuration": [
            "id 249, present",
            "id 250, present"
          ]
        },
        "id 2, present"
      ],
      "repo_count": [
        "id 1, present",
        "id 1, present, duplicate"
      ],
      "request_yaml_config": [
        {
          "_": "id 1, present",
          "request": [
            {
              "_": "id 37, present",
              "abuse": [
                "id 33, present",
                "id 34, present"
              ],
              "message": [
                "id 33, present",
                "id 34, present"
              ],
              "job": [
                {
                  "_": "id 176, present",
                  "queueable_job": [
                    "id 61, present",
                    "id 62, present"
                  ],
                  "job_version": [
                    "id 61, present",
                    "id 62, present"
                  ]
                },
                "id 177, present"
              ],
              "build": [
                {
                  "_": "id 173, present",
                  "job": [
                    "id 174, present"
                  ],
                  "repository": [
                    "id 71, present",
                    "id 70, present"
                  ],
                  "tag": [
                    "id 41, present"
                  ],
                  "branch": [
                    "id 41, present"
                  ],
                  "stage": [
                    "id 37, present"
                  ]
                },
                "id 175, present"
              ],
              "request_payload": [
                "id 33, present",
                "id 34, present"
              ],
              "request_raw_configuration": [
                "id 35, present",
                "id 36, present"
              ],
              "deleted_job": [
                "id 417, present",
                "id 418, present"
              ],
              "deleted_build": [
                "id 459, present",
                "id 460, present"
              ],
              "deleted_request_payload": [
                "id 237, present",
                "id 238, present"
              ],
              "deleted_request_raw_configuration": [
                "id 251, present",
                "id 252, present"
              ]
            },
            "id 38, present"
          ],
          "deleted_request": [
            "id 235, present",
            "id 236, present"
          ]
        },
        "id 2, present"
      ],
      "deleted_build": [
        "id 461, present",
        "id 462, present"
      ],
      "deleted_request": [
        "id 237, present",
        "id 238, present"
      ],
      "deleted_job": [
        "id 419, present",
        "id 420, present"
      ],
      "deleted_ssl_key": [
        "id 13, present",
        "id 14, present"
      ],
      "deleted_commit": [
        "id 97, present",
        "id 98, present"
      ],
      "deleted_pull_request": [
        "id 13, present",
        "id 14, present"
      ],
      "deleted_tag": [
        "id 27, present",
        "id 28, present"
      ],
      "deleted_build_config": [
        "id 13, present",
        "id 14, present"
      ],
      "deleted_request_config": [
        "id 13, present",
        "id 14, present"
      ],
      "deleted_job_config": [
        "id 13, present",
        "id 14, present"
      ],
      "deleted_request_raw_config": [
        "id 13, present",
        "id 14, present"
      ],
      "deleted_request_yaml_config": [
        "id 13, present",
        "id 14, present"
      ]
    }
  end
end