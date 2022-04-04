class ExpectedDependencyTrees
  def self.remove_org_with_dependencies
    {
      "_": "id 1, removed",
      "build": [
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
            "id 184, removed",
            "id 185, removed"
          ],
          "repository": [
            {
              "_": "id 91, present",
              "build": [
                "id 226, present"
              ],
              "request": [
                "id 48, present"
              ],
              "job": [
                "id 227, present"
              ],
              "branch": [
                "id 53, present"
              ],
              "ssl_key": [
                "id 8, present"
              ],
              "commit": [
                "id 24, present"
              ],
              "permission": [
                "id 8, present"
              ],
              "star": [
                "id 8, present"
              ],
              "pull_request": [
                "id 8, present"
              ],
              "tag": [
                "id 53, present"
              ]
            },
            "id 92, present",
            {
              "_": "id 89, present",
              "build": [
                "id 224, present"
              ],
              "request": [
                "id 47, present"
              ],
              "job": [
                "id 225, present"
              ],
              "branch": [
                "id 52, present"
              ],
              "ssl_key": [
                "id 7, present"
              ],
              "commit": [
                "id 23, present"
              ],
              "permission": [
                "id 7, present"
              ],
              "star": [
                "id 7, present"
              ],
              "pull_request": [
                "id 7, present"
              ],
              "tag": [
                "id 52, present"
              ]
            },
            "id 90, present"
          ],
          "tag": [
            {
              "_": "id 42, present",
              "build": [
                {
                  "_": "id 186, present",
                  "job": [
                    "id 187, present"
                  ],
                  "repository": [
                    "id 74, present",
                    "id 73, present"
                  ],
                  "tag": [
                    "id 43, present"
                  ],
                  "branch": [
                    "id 42, present"
                  ],
                  "stage": [
                    "id 41, present"
                  ]
                },
                "id 188, present"
              ],
              "commit": [
                {
                  "_": "id 19, present",
                  "build": [
                    {
                      "_": "id 189, present",
                      "job": [
                        "id 190, present"
                      ],
                      "repository": [
                        "id 76, present",
                        "id 75, present"
                      ],
                      "tag": [
                        "id 44, present"
                      ],
                      "branch": [
                        "id 43, present"
                      ],
                      "stage": [
                        "id 42, present"
                      ]
                    },
                    "id 191, present"
                  ],
                  "job": [
                    {
                      "_": "id 192, present",
                      "queueable_job": [
                        "id 65, present",
                        "id 66, present"
                      ],
                      "job_version": [
                        "id 65, present",
                        "id 66, present"
                      ]
                    },
                    "id 193, present"
                  ],
                  "request": [
                    {
                      "_": "id 39, present",
                      "abuse": [
                        "id 35, present",
                        "id 36, present"
                      ],
                      "message": [
                        "id 35, present",
                        "id 36, present"
                      ],
                      "job": [
                        {
                          "_": "id 197, present",
                          "queueable_job": [
                            "id 67, present",
                            "id 68, present"
                          ],
                          "job_version": [
                            "id 67, present",
                            "id 68, present"
                          ]
                        },
                        "id 198, present"
                      ],
                      "build": [
                        {
                          "_": "id 194, present",
                          "job": [
                            "id 195, present"
                          ],
                          "repository": [
                            "id 78, present",
                            "id 77, present"
                          ],
                          "tag": [
                            "id 45, present"
                          ],
                          "branch": [
                            "id 44, present"
                          ],
                          "stage": [
                            "id 43, present"
                          ]
                        },
                        "id 196, present"
                      ],
                      "request_payload": [
                        "id 35, present",
                        "id 36, present"
                      ],
                      "request_raw_configuration": [
                        "id 37, present",
                        "id 38, present"
                      ],
                      "deleted_job": [
                        "id 61, present",
                        "id 62, present"
                      ],
                      "deleted_build": [
                        "id 67, present",
                        "id 68, present"
                      ],
                      "deleted_request_payload": [
                        "id 35, present",
                        "id 36, present"
                      ],
                      "deleted_request_raw_configuration": [
                        "id 37, present",
                        "id 38, present"
                      ]
                    },
                    "id 40, present"
                  ],
                  "deleted_build": [
                    "id 69, present",
                    "id 70, present"
                  ],
                  "deleted_job": [
                    "id 63, present",
                    "id 64, present"
                  ],
                  "deleted_request": [
                    "id 35, present",
                    "id 36, present"
                  ]
                },
                "id 20, present"
              ],
              "request": [
                {
                  "_": "id 41, present",
                  "abuse": [
                    "id 37, present",
                    "id 38, present"
                  ],
                  "message": [
                    "id 37, present",
                    "id 38, present"
                  ],
                  "job": [
                    {
                      "_": "id 202, present",
                      "queueable_job": [
                        "id 69, present",
                        "id 70, present"
                      ],
                      "job_version": [
                        "id 69, present",
                        "id 70, present"
                      ]
                    },
                    "id 203, present"
                  ],
                  "build": [
                    {
                      "_": "id 199, present",
                      "job": [
                        "id 200, present"
                      ],
                      "repository": [
                        "id 80, present",
                        "id 79, present"
                      ],
                      "tag": [
                        "id 46, present"
                      ],
                      "branch": [
                        "id 45, present"
                      ],
                      "stage": [
                        "id 44, present"
                      ]
                    },
                    "id 201, present"
                  ],
                  "request_payload": [
                    "id 37, present",
                    "id 38, present"
                  ],
                  "request_raw_configuration": [
                    "id 39, present",
                    "id 40, present"
                  ],
                  "deleted_job": [
                    "id 65, present",
                    "id 66, present"
                  ],
                  "deleted_build": [
                    "id 71, present",
                    "id 72, present"
                  ],
                  "deleted_request_payload": [
                    "id 37, present",
                    "id 38, present"
                  ],
                  "deleted_request_raw_configuration": [
                    "id 39, present",
                    "id 40, present"
                  ]
                },
                "id 42, present"
              ],
              "deleted_build": [
                "id 73, present",
                "id 74, present"
              ],
              "deleted_commit": [
                "id 15, present",
                "id 16, present"
              ],
              "deleted_request": [
                "id 37, present",
                "id 38, present"
              ]
            },
            "id 47, present"
          ],
          "branch": [
            {
              "_": "id 46, present",
              "build": [
                {
                  "_": "id 204, present",
                  "job": [
                    "id 205, present"
                  ],
                  "repository": [
                    "id 82, present",
                    "id 81, present"
                  ],
                  "tag": [
                    "id 48, present"
                  ],
                  "branch": [
                    "id 47, present"
                  ],
                  "stage": [
                    "id 45, present"
                  ]
                },
                "id 206, present"
              ],
              "commit": [
                {
                  "_": "id 21, present",
                  "build": [
                    {
                      "_": "id 209, present",
                      "job": [
                        "id 210, present"
                      ],
                      "repository": [
                        "id 84, present",
                        "id 83, present"
                      ],
                      "tag": [
                        "id 49, present"
                      ],
                      "branch": [
                        "id 48, present"
                      ],
                      "stage": [
                        "id 46, present"
                      ]
                    },
                    "id 211, present"
                  ],
                  "job": [
                    {
                      "_": "id 212, present",
                      "queueable_job": [
                        "id 73, present",
                        "id 74, present"
                      ],
                      "job_version": [
                        "id 73, present",
                        "id 74, present"
                      ]
                    },
                    "id 213, present"
                  ],
                  "request": [
                    {
                      "_": "id 43, present",
                      "abuse": [
                        "id 39, present",
                        "id 40, present"
                      ],
                      "message": [
                        "id 39, present",
                        "id 40, present"
                      ],
                      "job": [
                        {
                          "_": "id 217, present",
                          "queueable_job": [
                            "id 75, present",
                            "id 76, present"
                          ],
                          "job_version": [
                            "id 75, present",
                            "id 76, present"
                          ]
                        },
                        "id 218, present"
                      ],
                      "build": [
                        {
                          "_": "id 214, present",
                          "job": [
                            "id 215, present"
                          ],
                          "repository": [
                            "id 86, present",
                            "id 85, present"
                          ],
                          "tag": [
                            "id 50, present"
                          ],
                          "branch": [
                            "id 49, present"
                          ],
                          "stage": [
                            "id 47, present"
                          ]
                        },
                        "id 216, present"
                      ],
                      "request_payload": [
                        "id 39, present",
                        "id 40, present"
                      ],
                      "request_raw_configuration": [
                        "id 41, present",
                        "id 42, present"
                      ],
                      "deleted_job": [
                        "id 69, present",
                        "id 70, present"
                      ],
                      "deleted_build": [
                        "id 77, present",
                        "id 78, present"
                      ],
                      "deleted_request_payload": [
                        "id 39, present",
                        "id 40, present"
                      ],
                      "deleted_request_raw_configuration": [
                        "id 41, present",
                        "id 42, present"
                      ]
                    },
                    "id 44, present"
                  ],
                  "deleted_build": [
                    "id 79, present",
                    "id 80, present"
                  ],
                  "deleted_job": [
                    "id 71, present",
                    "id 72, present"
                  ],
                  "deleted_request": [
                    "id 39, present",
                    "id 40, present"
                  ]
                },
                "id 22, present"
              ],
              "cron": [
                "id 4, present"
              ],
              "job": [
                {
                  "_": "id 207, present",
                  "queueable_job": [
                    "id 71, present",
                    "id 72, present"
                  ],
                  "job_version": [
                    "id 71, present",
                    "id 72, present"
                  ]
                },
                "id 208, present"
              ],
              "request": [
                {
                  "_": "id 45, present",
                  "abuse": [
                    "id 41, present",
                    "id 42, present"
                  ],
                  "message": [
                    "id 41, present",
                    "id 42, present"
                  ],
                  "job": [
                    {
                      "_": "id 222, present",
                      "queueable_job": [
                        "id 77, present",
                        "id 78, present"
                      ],
                      "job_version": [
                        "id 77, present",
                        "id 78, present"
                      ]
                    },
                    "id 223, present"
                  ],
                  "build": [
                    {
                      "_": "id 219, present",
                      "job": [
                        "id 220, present"
                      ],
                      "repository": [
                        "id 88, present",
                        "id 87, present"
                      ],
                      "tag": [
                        "id 51, present"
                      ],
                      "branch": [
                        "id 50, present"
                      ],
                      "stage": [
                        "id 48, present"
                      ]
                    },
                    "id 221, present"
                  ],
                  "request_payload": [
                    "id 41, present",
                    "id 42, present"
                  ],
                  "request_raw_configuration": [
                    "id 43, present",
                    "id 44, present"
                  ],
                  "deleted_job": [
                    "id 73, present",
                    "id 74, present"
                  ],
                  "deleted_build": [
                    "id 81, present",
                    "id 82, present"
                  ],
                  "deleted_request_payload": [
                    "id 41, present",
                    "id 42, present"
                  ],
                  "deleted_request_raw_configuration": [
                    "id 43, present",
                    "id 44, present"
                  ]
                },
                "id 46, present"
              ],
              "deleted_build": [
                "id 75, present",
                "id 76, present"
              ],
              "deleted_commit": [
                "id 17, present",
                "id 18, present"
              ],
              "deleted_job": [
                "id 67, present",
                "id 68, present"
              ],
              "deleted_request": [
                "id 41, present",
                "id 42, present"
              ]
            },
            "id 51, present"
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
            },
            "id 40, removed"
          ],
          "deleted_job": [
            "id 75, removed"
          ],
          "deleted_tag": [
            "id 5, present"
          ],
          "deleted_stage": [
            "id 3, removed"
          ]
        },
        {
          "_": "id 228, removed",
          "repository": [
            {
              "_": "id 1, removed",
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
                                "id 1, present",
                                "id 2, present"
                              ],
                              "deleted_build": [
                                "id 1, present",
                                "id 2, present"
                              ],
                              "deleted_request_payload": [
                                "id 1, present",
                                "id 2, present"
                              ],
                              "deleted_request_raw_configuration": [
                                "id 1, present",
                                "id 2, present"
                              ]
                            },
                            "id 2, present"
                          ],
                          "deleted_build": [
                            "id 3, present",
                            "id 4, present"
                          ],
                          "deleted_job": [
                            "id 3, present",
                            "id 4, present"
                          ],
                          "deleted_request": [
                            "id 1, present",
                            "id 2, present"
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
                            "id 5, present",
                            "id 6, present"
                          ],
                          "deleted_build": [
                            "id 5, present",
                            "id 6, present"
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
                        "id 4, present"
                      ],
                      "deleted_build": [
                        "id 7, present",
                        "id 8, present"
                      ],
                      "deleted_commit": [
                        "id 1, present",
                        "id 2, present"
                      ],
                      "deleted_request": [
                        "id 3, present",
                        "id 4, present"
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
                                "id 9, present",
                                "id 10, present"
                              ],
                              "deleted_build": [
                                "id 11, present",
                                "id 12, present"
                              ],
                              "deleted_request_payload": [
                                "id 5, present",
                                "id 6, present"
                              ],
                              "deleted_request_raw_configuration": [
                                "id 5, present",
                                "id 6, present"
                              ]
                            },
                            "id 6, present"
                          ],
                          "deleted_build": [
                            "id 13, present",
                            "id 14, present"
                          ],
                          "deleted_job": [
                            "id 11, present",
                            "id 12, present"
                          ],
                          "deleted_request": [
                            "id 5, present",
                            "id 6, present"
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
                            "id 13, present",
                            "id 14, present"
                          ],
                          "deleted_build": [
                            "id 15, present",
                            "id 16, present"
                          ],
                          "deleted_request_payload": [
                            "id 7, present",
                            "id 8, present"
                          ],
                          "deleted_request_raw_configuration": [
                            "id 7, present",
                            "id 8, present"
                          ]
                        },
                        "id 8, present"
                      ],
                      "deleted_build": [
                        "id 9, present",
                        "id 10, present"
                      ],
                      "deleted_commit": [
                        "id 3, present",
                        "id 4, present"
                      ],
                      "deleted_job": [
                        "id 7, present",
                        "id 8, present"
                      ],
                      "deleted_request": [
                        "id 7, present",
                        "id 8, present"
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
                    "id 15, removed"
                  ],
                  "deleted_tag": [
                    "id 1, present"
                  ],
                  "deleted_stage": [
                    "id 1, removed"
                  ]
                },
                "id 51, removed"
              ],
              "request": [
                {
                  "_": "id 11, removed",
                  "abuse": [
                    "id 9, removed",
                    "id 10, removed"
                  ],
                  "message": [
                    "id 9, removed",
                    "id 10, removed"
                  ],
                  "job": [
                    {
                      "_": "id 55, removed",
                      "queueable_job": [
                        "id 17, removed",
                        "id 18, removed"
                      ],
                      "job_version": [
                        "id 17, removed",
                        "id 18, removed"
                      ]
                    },
                    "id 56, removed"
                  ],
                  "build": [
                    {
                      "_": "id 52, removed",
                      "job": [
                        "id 53, removed"
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
                        "id 12, removed"
                      ]
                    },
                    "id 54, removed"
                  ],
                  "request_payload": [
                    "id 9, removed",
                    "id 10, removed"
                  ],
                  "request_raw_configuration": [
                    "id 9, removed",
                    "id 10, removed"
                  ],
                  "deleted_job": [
                    "id 16, removed",
                    "id 17, removed"
                  ],
                  "deleted_build": [
                    "id 17, removed",
                    "id 18, removed"
                  ],
                  "deleted_request_payload": [
                    "id 9, removed",
                    "id 10, removed"
                  ],
                  "deleted_request_raw_configuration": [
                    "id 9, removed",
                    "id 10, removed"
                  ]
                },
                "id 12, removed"
              ],
              "job": [
                {
                  "_": "id 57, removed",
                  "queueable_job": [
                    "id 19, removed",
                    "id 20, removed"
                  ],
                  "job_version": [
                    "id 19, removed",
                    "id 20, removed"
                  ]
                },
                "id 58, removed"
              ],
              "branch": [
                {
                  "_": "id 14, removed",
                  "build": [
                    {
                      "_": "id 59, removed",
                      "job": [
                        "id 60, removed"
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
                        "id 13, removed"
                      ]
                    },
                    "id 61, removed"
                  ],
                  "commit": [
                    {
                      "_": "id 7, removed",
                      "build": [
                        {
                          "_": "id 64, removed",
                          "job": [
                            "id 65, removed"
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
                            "id 14, removed"
                          ]
                        },
                        "id 66, removed"
                      ],
                      "job": [
                        {
                          "_": "id 67, removed",
                          "queueable_job": [
                            "id 23, removed",
                            "id 24, removed"
                          ],
                          "job_version": [
                            "id 23, removed",
                            "id 24, removed"
                          ]
                        },
                        "id 68, removed"
                      ],
                      "request": [
                        {
                          "_": "id 13, removed",
                          "abuse": [
                            "id 11, removed",
                            "id 12, removed"
                          ],
                          "message": [
                            "id 11, removed",
                            "id 12, removed"
                          ],
                          "job": [
                            {
                              "_": "id 72, removed",
                              "queueable_job": [
                                "id 25, removed",
                                "id 26, removed"
                              ],
                              "job_version": [
                                "id 25, removed",
                                "id 26, removed"
                              ]
                            },
                            "id 73, removed"
                          ],
                          "build": [
                            {
                              "_": "id 69, removed",
                              "job": [
                                "id 70, removed"
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
                                "id 15, removed"
                              ]
                            },
                            "id 71, removed"
                          ],
                          "request_payload": [
                            "id 11, removed",
                            "id 12, removed"
                          ],
                          "request_raw_configuration": [
                            "id 11, removed",
                            "id 12, removed"
                          ],
                          "deleted_job": [
                            "id 20, removed",
                            "id 21, removed"
                          ],
                          "deleted_build": [
                            "id 21, removed",
                            "id 22, removed"
                          ],
                          "deleted_request_payload": [
                            "id 11, removed",
                            "id 12, removed"
                          ],
                          "deleted_request_raw_configuration": [
                            "id 11, removed",
                            "id 12, removed"
                          ]
                        },
                        "id 14, removed"
                      ],
                      "deleted_build": [
                        "id 23, removed",
                        "id 24, removed"
                      ],
                      "deleted_job": [
                        "id 22, removed",
                        "id 23, removed"
                      ],
                      "deleted_request": [
                        "id 9, removed",
                        "id 10, removed"
                      ]
                    },
                    "id 8, removed"
                  ],
                  "cron": [
                    "id 2, removed"
                  ],
                  "job": [
                    {
                      "_": "id 62, removed",
                      "queueable_job": [
                        "id 21, removed",
                        "id 22, removed"
                      ],
                      "job_version": [
                        "id 21, removed",
                        "id 22, removed"
                      ]
                    },
                    "id 63, removed"
                  ],
                  "request": [
                    {
                      "_": "id 15, removed",
                      "abuse": [
                        "id 13, removed",
                        "id 14, removed"
                      ],
                      "message": [
                        "id 13, removed",
                        "id 14, removed"
                      ],
                      "job": [
                        {
                          "_": "id 77, removed",
                          "queueable_job": [
                            "id 27, removed",
                            "id 28, removed"
                          ],
                          "job_version": [
                            "id 27, removed",
                            "id 28, removed"
                          ]
                        },
                        "id 78, removed"
                      ],
                      "build": [
                        {
                          "_": "id 74, removed",
                          "job": [
                            "id 75, removed"
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
                            "id 16, removed"
                          ]
                        },
                        "id 76, removed"
                      ],
                      "request_payload": [
                        "id 13, removed",
                        "id 14, removed"
                      ],
                      "request_raw_configuration": [
                        "id 13, removed",
                        "id 14, removed"
                      ],
                      "deleted_job": [
                        "id 24, removed",
                        "id 25, removed"
                      ],
                      "deleted_build": [
                        "id 25, removed",
                        "id 26, removed"
                      ],
                      "deleted_request_payload": [
                        "id 13, removed",
                        "id 14, removed"
                      ],
                      "deleted_request_raw_configuration": [
                        "id 13, removed",
                        "id 14, removed"
                      ]
                    },
                    "id 16, removed"
                  ],
                  "deleted_build": [
                    "id 19, removed",
                    "id 20, removed"
                  ],
                  "deleted_commit": [
                    "id 5, removed",
                    "id 6, removed"
                  ],
                  "deleted_job": [
                    "id 18, removed",
                    "id 19, removed"
                  ],
                  "deleted_request": [
                    "id 11, removed",
                    "id 12, removed"
                  ]
                },
                "id 19, removed"
              ],
              "ssl_key": [
                "id 3, removed",
                "id 4, removed"
              ],
              "commit": [
                {
                  "_": "id 9, removed",
                  "build": [
                    {
                      "_": "id 79, removed",
                      "job": [
                        "id 80, removed"
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
                        "id 17, removed"
                      ]
                    },
                    "id 81, removed"
                  ],
                  "job": [
                    {
                      "_": "id 82, removed",
                      "queueable_job": [
                        "id 29, removed",
                        "id 30, removed"
                      ],
                      "job_version": [
                        "id 29, removed",
                        "id 30, removed"
                      ]
                    },
                    "id 83, removed"
                  ],
                  "request": [
                    {
                      "_": "id 17, removed",
                      "abuse": [
                        "id 15, removed",
                        "id 16, removed"
                      ],
                      "message": [
                        "id 15, removed",
                        "id 16, removed"
                      ],
                      "job": [
                        {
                          "_": "id 87, removed",
                          "queueable_job": [
                            "id 31, removed",
                            "id 32, removed"
                          ],
                          "job_version": [
                            "id 31, removed",
                            "id 32, removed"
                          ]
                        },
                        "id 88, removed"
                      ],
                      "build": [
                        {
                          "_": "id 84, removed",
                          "job": [
                            "id 85, removed"
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
                            "id 18, removed"
                          ]
                        },
                        "id 86, removed"
                      ],
                      "request_payload": [
                        "id 15, removed",
                        "id 16, removed"
                      ],
                      "request_raw_configuration": [
                        "id 15, removed",
                        "id 16, removed"
                      ],
                      "deleted_job": [
                        "id 26, removed",
                        "id 27, removed"
                      ],
                      "deleted_build": [
                        "id 27, removed",
                        "id 28, removed"
                      ],
                      "deleted_request_payload": [
                        "id 15, removed",
                        "id 16, removed"
                      ],
                      "deleted_request_raw_configuration": [
                        "id 15, removed",
                        "id 16, removed"
                      ]
                    },
                    "id 18, removed"
                  ],
                  "deleted_build": [
                    "id 29, removed",
                    "id 30, removed"
                  ],
                  "deleted_job": [
                    "id 28, removed",
                    "id 29, removed"
                  ],
                  "deleted_request": [
                    "id 13, removed",
                    "id 14, removed"
                  ]
                },
                "id 10, removed"
              ],
              "permission": [
                "id 3, removed",
                "id 4, removed"
              ],
              "star": [
                "id 3, removed",
                "id 4, removed"
              ],
              "pull_request": [
                {
                  "_": "id 3, removed",
                  "request": [
                    {
                      "_": "id 29, removed",
                      "abuse": [
                        "id 25, removed",
                        "id 26, removed"
                      ],
                      "message": [
                        "id 25, removed",
                        "id 26, removed"
                      ],
                      "job": [
                        {
                          "_": "id 143, removed",
                          "queueable_job": [
                            "id 49, removed",
                            "id 50, removed"
                          ],
                          "job_version": [
                            "id 49, removed",
                            "id 50, removed"
                          ]
                        },
                        "id 144, removed"
                      ],
                      "build": [
                        {
                          "_": "id 140, removed",
                          "job": [
                            "id 141, removed"
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
                            "id 30, removed"
                          ]
                        },
                        "id 142, removed"
                      ],
                      "request_payload": [
                        "id 25, removed",
                        "id 26, removed"
                      ],
                      "request_raw_configuration": [
                        "id 25, removed",
                        "id 26, removed"
                      ],
                      "deleted_job": [
                        "id 45, removed",
                        "id 46, removed"
                      ],
                      "deleted_build": [
                        "id 47, removed",
                        "id 48, removed"
                      ],
                      "deleted_request_payload": [
                        "id 25, removed",
                        "id 26, removed"
                      ],
                      "deleted_request_raw_configuration": [
                        "id 25, removed",
                        "id 26, removed"
                      ]
                    },
                    "id 30, removed"
                  ],
                  "build": [
                    {
                      "_": "id 89, removed",
                      "job": [
                        {
                          "_": "id 94, removed",
                          "queueable_job": [
                            "id 33, removed",
                            "id 34, removed"
                          ],
                          "job_version": [
                            "id 33, removed",
                            "id 34, removed"
                          ]
                        },
                        "id 95, removed",
                        "id 96, removed"
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
                                    "id 30, present",
                                    "id 31, present"
                                  ],
                                  "deleted_build": [
                                    "id 31, present",
                                    "id 32, present"
                                  ],
                                  "deleted_request_payload": [
                                    "id 17, present",
                                    "id 18, present"
                                  ],
                                  "deleted_request_raw_configuration": [
                                    "id 17, present",
                                    "id 18, present"
                                  ]
                                },
                                "id 20, present"
                              ],
                              "deleted_build": [
                                "id 33, present",
                                "id 34, present"
                              ],
                              "deleted_job": [
                                "id 32, present",
                                "id 33, present"
                              ],
                              "deleted_request": [
                                "id 15, present",
                                "id 16, present"
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
                                "id 34, present",
                                "id 35, present"
                              ],
                              "deleted_build": [
                                "id 35, present",
                                "id 36, present"
                              ],
                              "deleted_request_payload": [
                                "id 19, present",
                                "id 20, present"
                              ],
                              "deleted_request_raw_configuration": [
                                "id 19, present",
                                "id 20, present"
                              ]
                            },
                            "id 22, present"
                          ],
                          "deleted_build": [
                            "id 37, present",
                            "id 38, present"
                          ],
                          "deleted_commit": [
                            "id 7, present",
                            "id 8, present"
                          ],
                          "deleted_request": [
                            "id 17, present",
                            "id 18, present"
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
                                    "id 38, present",
                                    "id 39, present"
                                  ],
                                  "deleted_build": [
                                    "id 41, present",
                                    "id 42, present"
                                  ],
                                  "deleted_request_payload": [
                                    "id 21, present",
                                    "id 22, present"
                                  ],
                                  "deleted_request_raw_configuration": [
                                    "id 21, present",
                                    "id 22, present"
                                  ]
                                },
                                "id 24, present"
                              ],
                              "deleted_build": [
                                "id 43, present",
                                "id 44, present"
                              ],
                              "deleted_job": [
                                "id 40, present",
                                "id 41, present"
                              ],
                              "deleted_request": [
                                "id 19, present",
                                "id 20, present"
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
                                "id 42, present",
                                "id 43, present"
                              ],
                              "deleted_build": [
                                "id 45, present",
                                "id 46, present"
                              ],
                              "deleted_request_payload": [
                                "id 23, present",
                                "id 24, present"
                              ],
                              "deleted_request_raw_configuration": [
                                "id 23, present",
                                "id 24, present"
                              ]
                            },
                            "id 26, present"
                          ],
                          "deleted_build": [
                            "id 39, present",
                            "id 40, present"
                          ],
                          "deleted_commit": [
                            "id 9, present",
                            "id 10, present"
                          ],
                          "deleted_job": [
                            "id 36, present",
                            "id 37, present"
                          ],
                          "deleted_request": [
                            "id 21, present",
                            "id 22, present"
                          ]
                        },
                        "id 31, present"
                      ],
                      "stage": [
                        {
                          "_": "id 19, removed",
                          "job": [
                            "id 90, removed",
                            "id 91, removed"
                          ]
                        },
                        {
                          "_": "id 20, removed",
                          "job": [
                            "id 92, removed",
                            "id 93, removed"
                          ]
                        },
                        "id 21, removed"
                      ],
                      "deleted_job": [
                        "id 44, removed"
                      ],
                      "deleted_tag": [
                        "id 2, present"
                      ],
                      "deleted_stage": [
                        "id 2, removed"
                      ]
                    },
                    "id 139, removed"
                  ],
                  "deleted_request": [
                    "id 23, removed",
                    "id 24, removed"
                  ],
                  "deleted_build": [
                    "id 49, removed",
                    "id 50, removed"
                  ]
                },
                "id 6, removed"
              ],
              "tag": [
                {
                  "_": "id 33, removed",
                  "build": [
                    {
                      "_": "id 145, removed",
                      "job": [
                        "id 146, removed"
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
                        "id 31, removed"
                      ]
                    },
                    "id 147, removed"
                  ],
                  "commit": [
                    {
                      "_": "id 17, removed",
                      "build": [
                        {
                          "_": "id 148, removed",
                          "job": [
                            "id 149, removed"
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
                            "id 32, removed"
                          ]
                        },
                        "id 150, removed"
                      ],
                      "job": [
                        {
                          "_": "id 151, removed",
                          "queueable_job": [
                            "id 51, removed",
                            "id 52, removed"
                          ],
                          "job_version": [
                            "id 51, removed",
                            "id 52, removed"
                          ]
                        },
                        "id 152, removed"
                      ],
                      "request": [
                        {
                          "_": "id 31, removed",
                          "abuse": [
                            "id 27, removed",
                            "id 28, removed"
                          ],
                          "message": [
                            "id 27, removed",
                            "id 28, removed"
                          ],
                          "job": [
                            {
                              "_": "id 156, removed",
                              "queueable_job": [
                                "id 53, removed",
                                "id 54, removed"
                              ],
                              "job_version": [
                                "id 53, removed",
                                "id 54, removed"
                              ]
                            },
                            "id 157, removed"
                          ],
                          "build": [
                            {
                              "_": "id 153, removed",
                              "job": [
                                "id 154, removed"
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
                                "id 33, removed"
                              ]
                            },
                            "id 155, removed"
                          ],
                          "request_payload": [
                            "id 27, removed",
                            "id 28, removed"
                          ],
                          "request_raw_configuration": [
                            "id 27, removed",
                            "id 28, removed"
                          ],
                          "deleted_job": [
                            "id 47, removed",
                            "id 48, removed"
                          ],
                          "deleted_build": [
                            "id 51, removed",
                            "id 52, removed"
                          ],
                          "deleted_request_payload": [
                            "id 27, removed",
                            "id 28, removed"
                          ],
                          "deleted_request_raw_configuration": [
                            "id 27, removed",
                            "id 28, removed"
                          ]
                        },
                        "id 32, removed"
                      ],
                      "deleted_build": [
                        "id 53, removed",
                        "id 54, removed"
                      ],
                      "deleted_job": [
                        "id 49, removed",
                        "id 50, removed"
                      ],
                      "deleted_request": [
                        "id 25, removed",
                        "id 26, removed"
                      ]
                    },
                    "id 18, removed"
                  ],
                  "request": [
                    {
                      "_": "id 33, removed",
                      "abuse": [
                        "id 29, removed",
                        "id 30, removed"
                      ],
                      "message": [
                        "id 29, removed",
                        "id 30, removed"
                      ],
                      "job": [
                        {
                          "_": "id 161, removed",
                          "queueable_job": [
                            "id 55, removed",
                            "id 56, removed"
                          ],
                          "job_version": [
                            "id 55, removed",
                            "id 56, removed"
                          ]
                        },
                        "id 162, removed"
                      ],
                      "build": [
                        {
                          "_": "id 158, removed",
                          "job": [
                            "id 159, removed"
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
                            "id 34, removed"
                          ]
                        },
                        "id 160, removed"
                      ],
                      "request_payload": [
                        "id 29, removed",
                        "id 30, removed"
                      ],
                      "request_raw_configuration": [
                        "id 29, removed",
                        "id 30, removed"
                      ],
                      "deleted_job": [
                        "id 51, removed",
                        "id 52, removed"
                      ],
                      "deleted_build": [
                        "id 55, removed",
                        "id 56, removed"
                      ],
                      "deleted_request_payload": [
                        "id 29, removed",
                        "id 30, removed"
                      ],
                      "deleted_request_raw_configuration": [
                        "id 29, removed",
                        "id 30, removed"
                      ]
                    },
                    "id 34, removed"
                  ],
                  "deleted_build": [
                    "id 57, removed",
                    "id 58, removed"
                  ],
                  "deleted_commit": [
                    "id 11, removed",
                    "id 12, removed"
                  ],
                  "deleted_request": [
                    "id 27, removed",
                    "id 28, removed"
                  ]
                },
                "id 38, removed"
              ],
              "build_config": [
                {
                  "_": "id 1, removed",
                  "build": [
                    {
                      "_": "id 163, removed",
                      "job": [
                        "id 164, removed"
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
                        "id 35, removed"
                      ]
                    },
                    "id 165, removed"
                  ],
                  "deleted_build": [
                    "id 59, removed",
                    "id 60, removed"
                  ]
                },
                "id 2, removed"
              ],
              "email_unsubscribe": [
                "id 1, removed",
                "id 2, removed"
              ],
              "request_config": [
                {
                  "_": "id 1, removed",
                  "request": [
                    {
                      "_": "id 35, removed",
                      "abuse": [
                        "id 31, removed",
                        "id 32, removed"
                      ],
                      "message": [
                        "id 31, removed",
                        "id 32, removed"
                      ],
                      "job": [
                        {
                          "_": "id 169, removed",
                          "queueable_job": [
                            "id 57, removed",
                            "id 58, removed"
                          ],
                          "job_version": [
                            "id 57, removed",
                            "id 58, removed"
                          ]
                        },
                        "id 170, removed"
                      ],
                      "build": [
                        {
                          "_": "id 166, removed",
                          "job": [
                            "id 167, removed"
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
                            "id 36, removed"
                          ]
                        },
                        "id 168, removed"
                      ],
                      "request_payload": [
                        "id 31, removed",
                        "id 32, removed"
                      ],
                      "request_raw_configuration": [
                        "id 31, removed",
                        "id 32, removed"
                      ],
                      "deleted_job": [
                        "id 53, removed",
                        "id 54, removed"
                      ],
                      "deleted_build": [
                        "id 61, removed",
                        "id 62, removed"
                      ],
                      "deleted_request_payload": [
                        "id 31, removed",
                        "id 32, removed"
                      ],
                      "deleted_request_raw_configuration": [
                        "id 31, removed",
                        "id 32, removed"
                      ]
                    },
                    "id 36, removed"
                  ],
                  "deleted_request": [
                    "id 29, removed",
                    "id 30, removed"
                  ]
                },
                "id 2, removed"
              ],
              "job_config": [
                {
                  "_": "id 1, removed",
                  "job": [
                    {
                      "_": "id 171, removed",
                      "queueable_job": [
                        "id 59, removed",
                        "id 60, removed"
                      ],
                      "job_version": [
                        "id 59, removed",
                        "id 60, removed"
                      ]
                    },
                    "id 172, removed"
                  ],
                  "deleted_job": [
                    "id 55, removed",
                    "id 56, removed"
                  ]
                },
                "id 2, removed"
              ],
              "request_raw_config": [
                {
                  "_": "id 1, removed",
                  "request_raw_configuration": [
                    "id 33, removed",
                    "id 34, removed"
                  ],
                  "deleted_request_raw_configuration": [
                    "id 33, removed",
                    "id 34, removed"
                  ]
                },
                "id 2, removed"
              ],
              "repo_count": [
                "id 1, removed",
                "id 1, removed, duplicate"
              ],
              "request_yaml_config": [
                {
                  "_": "id 1, removed",
                  "request": [
                    {
                      "_": "id 37, removed",
                      "abuse": [
                        "id 33, removed",
                        "id 34, removed"
                      ],
                      "message": [
                        "id 33, removed",
                        "id 34, removed"
                      ],
                      "job": [
                        {
                          "_": "id 176, removed",
                          "queueable_job": [
                            "id 61, removed",
                            "id 62, removed"
                          ],
                          "job_version": [
                            "id 61, removed",
                            "id 62, removed"
                          ]
                        },
                        "id 177, removed"
                      ],
                      "build": [
                        {
                          "_": "id 173, removed",
                          "job": [
                            "id 174, removed"
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
                            "id 37, removed"
                          ]
                        },
                        "id 175, removed"
                      ],
                      "request_payload": [
                        "id 33, removed",
                        "id 34, removed"
                      ],
                      "request_raw_configuration": [
                        "id 35, removed",
                        "id 36, removed"
                      ],
                      "deleted_job": [
                        "id 57, removed",
                        "id 58, removed"
                      ],
                      "deleted_build": [
                        "id 63, removed",
                        "id 64, removed"
                      ],
                      "deleted_request_payload": [
                        "id 33, removed",
                        "id 34, removed"
                      ],
                      "deleted_request_raw_configuration": [
                        "id 35, removed",
                        "id 36, removed"
                      ]
                    },
                    "id 38, removed"
                  ],
                  "deleted_request": [
                    "id 31, removed",
                    "id 32, removed"
                  ]
                },
                "id 2, removed"
              ],
              "deleted_build": [
                "id 65, removed",
                "id 66, removed"
              ],
              "deleted_request": [
                "id 33, removed",
                "id 34, removed"
              ],
              "deleted_job": [
                "id 59, removed",
                "id 60, removed"
              ],
              "deleted_ssl_key": [
                "id 1, removed",
                "id 2, removed"
              ],
              "deleted_commit": [
                "id 13, removed",
                "id 14, removed"
              ],
              "deleted_pull_request": [
                "id 1, removed",
                "id 2, removed"
              ],
              "deleted_tag": [
                "id 3, removed",
                "id 4, removed"
              ],
              "deleted_build_config": [
                "id 1, removed",
                "id 2, removed"
              ],
              "deleted_request_config": [
                "id 1, removed",
                "id 2, removed"
              ],
              "deleted_job_config": [
                "id 1, removed",
                "id 2, removed"
              ],
              "deleted_request_raw_config": [
                "id 1, removed",
                "id 2, removed"
              ],
              "deleted_request_yaml_config": [
                "id 1, removed",
                "id 2, removed"
              ]
            }
          ]
        },
        {
          "_": "id 229, removed",
          "job": [
            {
              "_": "id 234, removed",
              "queueable_job": [
                "id 79, removed",
                "id 80, removed"
              ],
              "job_version": [
                "id 79, removed",
                "id 80, removed"
              ]
            },
            "id 235, removed",
            "id 236, removed"
          ],
          "repository": [
            {
              "_": "id 111, present",
              "build": [
                "id 277, present"
              ],
              "request": [
                "id 58, present"
              ],
              "job": [
                "id 278, present"
              ],
              "branch": [
                "id 65, present"
              ],
              "ssl_key": [
                "id 10, present"
              ],
              "commit": [
                "id 30, present"
              ],
              "permission": [
                "id 10, present"
              ],
              "star": [
                "id 10, present"
              ],
              "pull_request": [
                "id 10, present"
              ],
              "tag": [
                "id 65, present"
              ]
            },
            "id 112, present",
            {
              "_": "id 109, present",
              "build": [
                "id 275, present"
              ],
              "request": [
                "id 57, present"
              ],
              "job": [
                "id 276, present"
              ],
              "branch": [
                "id 64, present"
              ],
              "ssl_key": [
                "id 9, present"
              ],
              "commit": [
                "id 29, present"
              ],
              "permission": [
                "id 9, present"
              ],
              "star": [
                "id 9, present"
              ],
              "pull_request": [
                "id 9, present"
              ],
              "tag": [
                "id 64, present"
              ]
            },
            "id 110, present"
          ],
          "tag": [
            {
              "_": "id 54, present",
              "build": [
                {
                  "_": "id 237, present",
                  "job": [
                    "id 238, present"
                  ],
                  "repository": [
                    "id 94, present",
                    "id 93, present"
                  ],
                  "tag": [
                    "id 55, present"
                  ],
                  "branch": [
                    "id 54, present"
                  ],
                  "stage": [
                    "id 52, present"
                  ]
                },
                "id 239, present"
              ],
              "commit": [
                {
                  "_": "id 25, present",
                  "build": [
                    {
                      "_": "id 240, present",
                      "job": [
                        "id 241, present"
                      ],
                      "repository": [
                        "id 96, present",
                        "id 95, present"
                      ],
                      "tag": [
                        "id 56, present"
                      ],
                      "branch": [
                        "id 55, present"
                      ],
                      "stage": [
                        "id 53, present"
                      ]
                    },
                    "id 242, present"
                  ],
                  "job": [
                    {
                      "_": "id 243, present",
                      "queueable_job": [
                        "id 81, present",
                        "id 82, present"
                      ],
                      "job_version": [
                        "id 81, present",
                        "id 82, present"
                      ]
                    },
                    "id 244, present"
                  ],
                  "request": [
                    {
                      "_": "id 49, present",
                      "abuse": [
                        "id 43, present",
                        "id 44, present"
                      ],
                      "message": [
                        "id 43, present",
                        "id 44, present"
                      ],
                      "job": [
                        {
                          "_": "id 248, present",
                          "queueable_job": [
                            "id 83, present",
                            "id 84, present"
                          ],
                          "job_version": [
                            "id 83, present",
                            "id 84, present"
                          ]
                        },
                        "id 249, present"
                      ],
                      "build": [
                        {
                          "_": "id 245, present",
                          "job": [
                            "id 246, present"
                          ],
                          "repository": [
                            "id 98, present",
                            "id 97, present"
                          ],
                          "tag": [
                            "id 57, present"
                          ],
                          "branch": [
                            "id 56, present"
                          ],
                          "stage": [
                            "id 54, present"
                          ]
                        },
                        "id 247, present"
                      ],
                      "request_payload": [
                        "id 43, present",
                        "id 44, present"
                      ],
                      "request_raw_configuration": [
                        "id 45, present",
                        "id 46, present"
                      ],
                      "deleted_job": [
                        "id 76, present",
                        "id 77, present"
                      ],
                      "deleted_build": [
                        "id 83, present",
                        "id 84, present"
                      ],
                      "deleted_request_payload": [
                        "id 43, present",
                        "id 44, present"
                      ],
                      "deleted_request_raw_configuration": [
                        "id 45, present",
                        "id 46, present"
                      ]
                    },
                    "id 50, present"
                  ],
                  "deleted_build": [
                    "id 85, present",
                    "id 86, present"
                  ],
                  "deleted_job": [
                    "id 78, present",
                    "id 79, present"
                  ],
                  "deleted_request": [
                    "id 43, present",
                    "id 44, present"
                  ]
                },
                "id 26, present"
              ],
              "request": [
                {
                  "_": "id 51, present",
                  "abuse": [
                    "id 45, present",
                    "id 46, present"
                  ],
                  "message": [
                    "id 45, present",
                    "id 46, present"
                  ],
                  "job": [
                    {
                      "_": "id 253, present",
                      "queueable_job": [
                        "id 85, present",
                        "id 86, present"
                      ],
                      "job_version": [
                        "id 85, present",
                        "id 86, present"
                      ]
                    },
                    "id 254, present"
                  ],
                  "build": [
                    {
                      "_": "id 250, present",
                      "job": [
                        "id 251, present"
                      ],
                      "repository": [
                        "id 100, present",
                        "id 99, present"
                      ],
                      "tag": [
                        "id 58, present"
                      ],
                      "branch": [
                        "id 57, present"
                      ],
                      "stage": [
                        "id 55, present"
                      ]
                    },
                    "id 252, present"
                  ],
                  "request_payload": [
                    "id 45, present",
                    "id 46, present"
                  ],
                  "request_raw_configuration": [
                    "id 47, present",
                    "id 48, present"
                  ],
                  "deleted_job": [
                    "id 80, present",
                    "id 81, present"
                  ],
                  "deleted_build": [
                    "id 87, present",
                    "id 88, present"
                  ],
                  "deleted_request_payload": [
                    "id 45, present",
                    "id 46, present"
                  ],
                  "deleted_request_raw_configuration": [
                    "id 47, present",
                    "id 48, present"
                  ]
                },
                "id 52, present"
              ],
              "deleted_build": [
                "id 89, present",
                "id 90, present"
              ],
              "deleted_commit": [
                "id 19, present",
                "id 20, present"
              ],
              "deleted_request": [
                "id 45, present",
                "id 46, present"
              ]
            },
            "id 59, present"
          ],
          "branch": [
            {
              "_": "id 58, present",
              "build": [
                {
                  "_": "id 255, present",
                  "job": [
                    "id 256, present"
                  ],
                  "repository": [
                    "id 102, present",
                    "id 101, present"
                  ],
                  "tag": [
                    "id 60, present"
                  ],
                  "branch": [
                    "id 59, present"
                  ],
                  "stage": [
                    "id 56, present"
                  ]
                },
                "id 257, present"
              ],
              "commit": [
                {
                  "_": "id 27, present",
                  "build": [
                    {
                      "_": "id 260, present",
                      "job": [
                        "id 261, present"
                      ],
                      "repository": [
                        "id 104, present",
                        "id 103, present"
                      ],
                      "tag": [
                        "id 61, present"
                      ],
                      "branch": [
                        "id 60, present"
                      ],
                      "stage": [
                        "id 57, present"
                      ]
                    },
                    "id 262, present"
                  ],
                  "job": [
                    {
                      "_": "id 263, present",
                      "queueable_job": [
                        "id 89, present",
                        "id 90, present"
                      ],
                      "job_version": [
                        "id 89, present",
                        "id 90, present"
                      ]
                    },
                    "id 264, present"
                  ],
                  "request": [
                    {
                      "_": "id 53, present",
                      "abuse": [
                        "id 47, present",
                        "id 48, present"
                      ],
                      "message": [
                        "id 47, present",
                        "id 48, present"
                      ],
                      "job": [
                        {
                          "_": "id 268, present",
                          "queueable_job": [
                            "id 91, present",
                            "id 92, present"
                          ],
                          "job_version": [
                            "id 91, present",
                            "id 92, present"
                          ]
                        },
                        "id 269, present"
                      ],
                      "build": [
                        {
                          "_": "id 265, present",
                          "job": [
                            "id 266, present"
                          ],
                          "repository": [
                            "id 106, present",
                            "id 105, present"
                          ],
                          "tag": [
                            "id 62, present"
                          ],
                          "branch": [
                            "id 61, present"
                          ],
                          "stage": [
                            "id 58, present"
                          ]
                        },
                        "id 267, present"
                      ],
                      "request_payload": [
                        "id 47, present",
                        "id 48, present"
                      ],
                      "request_raw_configuration": [
                        "id 49, present",
                        "id 50, present"
                      ],
                      "deleted_job": [
                        "id 84, present",
                        "id 85, present"
                      ],
                      "deleted_build": [
                        "id 93, present",
                        "id 94, present"
                      ],
                      "deleted_request_payload": [
                        "id 47, present",
                        "id 48, present"
                      ],
                      "deleted_request_raw_configuration": [
                        "id 49, present",
                        "id 50, present"
                      ]
                    },
                    "id 54, present"
                  ],
                  "deleted_build": [
                    "id 95, present",
                    "id 96, present"
                  ],
                  "deleted_job": [
                    "id 86, present",
                    "id 87, present"
                  ],
                  "deleted_request": [
                    "id 47, present",
                    "id 48, present"
                  ]
                },
                "id 28, present"
              ],
              "cron": [
                "id 5, present"
              ],
              "job": [
                {
                  "_": "id 258, present",
                  "queueable_job": [
                    "id 87, present",
                    "id 88, present"
                  ],
                  "job_version": [
                    "id 87, present",
                    "id 88, present"
                  ]
                },
                "id 259, present"
              ],
              "request": [
                {
                  "_": "id 55, present",
                  "abuse": [
                    "id 49, present",
                    "id 50, present"
                  ],
                  "message": [
                    "id 49, present",
                    "id 50, present"
                  ],
                  "job": [
                    {
                      "_": "id 273, present",
                      "queueable_job": [
                        "id 93, present",
                        "id 94, present"
                      ],
                      "job_version": [
                        "id 93, present",
                        "id 94, present"
                      ]
                    },
                    "id 274, present"
                  ],
                  "build": [
                    {
                      "_": "id 270, present",
                      "job": [
                        "id 271, present"
                      ],
                      "repository": [
                        "id 108, present",
                        "id 107, present"
                      ],
                      "tag": [
                        "id 63, present"
                      ],
                      "branch": [
                        "id 62, present"
                      ],
                      "stage": [
                        "id 59, present"
                      ]
                    },
                    "id 272, present"
                  ],
                  "request_payload": [
                    "id 49, present",
                    "id 50, present"
                  ],
                  "request_raw_configuration": [
                    "id 51, present",
                    "id 52, present"
                  ],
                  "deleted_job": [
                    "id 88, present",
                    "id 89, present"
                  ],
                  "deleted_build": [
                    "id 97, present",
                    "id 98, present"
                  ],
                  "deleted_request_payload": [
                    "id 49, present",
                    "id 50, present"
                  ],
                  "deleted_request_raw_configuration": [
                    "id 51, present",
                    "id 52, present"
                  ]
                },
                "id 56, present"
              ],
              "deleted_build": [
                "id 91, present",
                "id 92, present"
              ],
              "deleted_commit": [
                "id 21, present",
                "id 22, present"
              ],
              "deleted_job": [
                "id 82, present",
                "id 83, present"
              ],
              "deleted_request": [
                "id 49, present",
                "id 50, present"
              ]
            },
            "id 63, present"
          ],
          "stage": [
            {
              "_": "id 49, removed",
              "job": [
                "id 230, removed",
                "id 231, removed"
              ]
            },
            {
              "_": "id 50, removed",
              "job": [
                "id 232, removed",
                "id 233, removed"
              ]
            },
            "id 51, removed"
          ],
          "deleted_job": [
            "id 90, removed"
          ],
          "deleted_tag": [
            "id 6, present"
          ],
          "deleted_stage": [
            "id 4, removed"
          ]
        },
        {
          "_": "id 279, removed",
          "repository": [
            "id 1, removed, duplicate"
          ]
        }
      ],
      "repository": [
        "id 1, removed, duplicate",
        "id 72, removed"
      ],
      "job": [
        {
          "_": "id 290, removed",
          "queueable_job": [
            "id 99, removed",
            "id 100, removed"
          ],
          "job_version": [
            "id 99, removed",
            "id 100, removed"
          ]
        },
        "id 291, removed"
      ],
      "request": [
        {
          "_": "id 61, removed",
          "abuse": [
            "id 53, removed",
            "id 54, removed"
          ],
          "message": [
            "id 53, removed",
            "id 54, removed"
          ],
          "job": [
            {
              "_": "id 288, removed",
              "queueable_job": [
                "id 97, removed",
                "id 98, removed"
              ],
              "job_version": [
                "id 97, removed",
                "id 98, removed"
              ]
            },
            "id 289, removed"
          ],
          "build": [
            {
              "_": "id 285, removed",
              "job": [
                "id 286, removed"
              ],
              "repository": [
                "id 116, present",
                "id 115, present"
              ],
              "tag": [
                "id 67, present"
              ],
              "branch": [
                "id 67, present"
              ],
              "stage": [
                "id 61, removed"
              ]
            },
            "id 287, removed"
          ],
          "request_payload": [
            "id 53, removed",
            "id 54, removed"
          ],
          "request_raw_configuration": [
            "id 55, removed",
            "id 56, removed"
          ],
          "deleted_job": [
            "id 93, removed",
            "id 94, removed"
          ],
          "deleted_build": [
            "id 101, removed",
            "id 102, removed"
          ],
          "deleted_request_payload": [
            "id 53, removed",
            "id 54, removed"
          ],
          "deleted_request_raw_configuration": [
            "id 55, removed",
            "id 56, removed"
          ]
        },
        "id 62, removed",
        {
          "_": "id 59, removed",
          "abuse": [
            "id 51, removed",
            "id 52, removed"
          ],
          "message": [
            "id 51, removed",
            "id 52, removed"
          ],
          "job": [
            {
              "_": "id 283, removed",
              "queueable_job": [
                "id 95, removed",
                "id 96, removed"
              ],
              "job_version": [
                "id 95, removed",
                "id 96, removed"
              ]
            },
            "id 284, removed"
          ],
          "build": [
            {
              "_": "id 280, removed",
              "job": [
                "id 281, removed"
              ],
              "repository": [
                "id 114, present",
                "id 113, present"
              ],
              "tag": [
                "id 66, present"
              ],
              "branch": [
                "id 66, present"
              ],
              "stage": [
                "id 60, removed"
              ]
            },
            "id 282, removed"
          ],
          "request_payload": [
            "id 51, removed",
            "id 52, removed"
          ],
          "request_raw_configuration": [
            "id 53, removed",
            "id 54, removed"
          ],
          "deleted_job": [
            "id 91, removed",
            "id 92, removed"
          ],
          "deleted_build": [
            "id 99, removed",
            "id 100, removed"
          ],
          "deleted_request_payload": [
            "id 51, removed",
            "id 52, removed"
          ],
          "deleted_request_raw_configuration": [
            "id 53, removed",
            "id 54, removed"
          ]
        },
        "id 60, removed"
      ],
      "abuse": [
        "id 55, removed",
        "id 56, removed"
      ],
      "subscription": [
        {
          "_": "id 1, removed",
          "invoice": [
            "id 1, removed",
            "id 2, removed"
          ]
        },
        {
          "_": "id 2, removed",
          "invoice": [
            "id 3, removed",
            "id 4, removed"
          ]
        }
      ],
      "owner_group": [
        "id 1, removed",
        "id 2, removed"
      ],
      "trial": [
        {
          "_": "id 1, removed",
          "trial_allowance": [
            "id 1, removed",
            "id 2, removed"
          ]
        },
        {
          "_": "id 2, removed",
          "trial_allowance": [
            "id 3, removed",
            "id 4, removed"
          ]
        }
      ],
      "trial_allowance": [
        "id 5, removed",
        "id 6, removed"
      ],
      "broadcast": [
        "id 1, removed",
        "id 2, removed"
      ],
      "membership": [
        "id 1, removed",
        "id 2, removed"
      ]
    }
  end
end