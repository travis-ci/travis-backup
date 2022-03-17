class ExpectedDependencyTrees
  def self.remove_repo_requests
    {
      "_": "id 1, present",
      "build": [
        {
          "_": "id 1, present",
          "job": [
            {
              "_": "id 6, present",
              "queueable_job": [
                "id 1, present",
                "id 2, present"
              ]
            },
            "id 7, present"
          ],
          "repository": [
            {
              "_": "id 20, present",
              "build": [
                "id 48, present"
              ],
              "request": [
                "id 10, present"
              ],
              "job": [
                "id 49, present"
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
                "id 46, present"
              ],
              "request": [
                "id 9, present"
              ],
              "job": [
                "id 47, present"
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
                  "_": "id 8, present",
                  "job": [
                    "id 9, present"
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
                    "id 3, present"
                  ]
                },
                "id 10, present"
              ],
              "commit": [
                {
                  "_": "id 1, present",
                  "build": [
                    {
                      "_": "id 11, present",
                      "job": [
                        "id 12, present"
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
                        "id 4, present"
                      ]
                    },
                    "id 13, present"
                  ],
                  "job": [
                    {
                      "_": "id 14, present",
                      "queueable_job": [
                        "id 3, present",
                        "id 4, present"
                      ]
                    },
                    "id 15, present"
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
                          "_": "id 19, present",
                          "queueable_job": [
                            "id 5, present",
                            "id 6, present"
                          ]
                        },
                        "id 20, present"
                      ],
                      "build": [
                        {
                          "_": "id 16, present",
                          "job": [
                            "id 17, present"
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
                            "id 5, present"
                          ]
                        },
                        "id 18, present"
                      ]
                    },
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
                      "_": "id 24, present",
                      "queueable_job": [
                        "id 7, present",
                        "id 8, present"
                      ]
                    },
                    "id 25, present"
                  ],
                  "build": [
                    {
                      "_": "id 21, present",
                      "job": [
                        "id 22, present"
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
                        "id 6, present"
                      ]
                    },
                    "id 23, present"
                  ]
                },
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
                  "_": "id 26, present",
                  "job": [
                    "id 27, present"
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
                    "id 7, present"
                  ]
                },
                "id 28, present"
              ],
              "commit": [
                {
                  "_": "id 3, present",
                  "build": [
                    {
                      "_": "id 31, present",
                      "job": [
                        "id 32, present"
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
                        "id 8, present"
                      ]
                    },
                    "id 33, present"
                  ],
                  "job": [
                    {
                      "_": "id 34, present",
                      "queueable_job": [
                        "id 11, present",
                        "id 12, present"
                      ]
                    },
                    "id 35, present"
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
                          "_": "id 39, present",
                          "queueable_job": [
                            "id 13, present",
                            "id 14, present"
                          ]
                        },
                        "id 40, present"
                      ],
                      "build": [
                        {
                          "_": "id 36, present",
                          "job": [
                            "id 37, present"
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
                            "id 9, present"
                          ]
                        },
                        "id 38, present"
                      ]
                    },
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
                  "_": "id 29, present",
                  "queueable_job": [
                    "id 9, present",
                    "id 10, present"
                  ]
                },
                "id 30, present"
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
                      "_": "id 44, present",
                      "queueable_job": [
                        "id 15, present",
                        "id 16, present"
                      ]
                    },
                    "id 45, present"
                  ],
                  "build": [
                    {
                      "_": "id 41, present",
                      "job": [
                        "id 42, present"
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
                        "id 10, present"
                      ]
                    },
                    "id 43, present"
                  ]
                },
                "id 8, present"
              ]
            },
            "id 10, present"
          ],
          "stage": [
            {
              "_": "id 1, present",
              "job": [
                "id 2, present",
                "id 3, present"
              ]
            },
            {
              "_": "id 2, present",
              "job": [
                "id 4, present",
                "id 5, present"
              ]
            }
          ]
        },
        "id 50, present",
        {
          "_": "id 161, present",
          "job": [
            {
              "_": "id 166, present",
              "queueable_job": [
                "id 57, present",
                "id 58, present"
              ]
            },
            "id 167, present"
          ],
          "stage": [
            {
              "_": "id 33, present",
              "job": [
                "id 162, present",
                "id 163, present"
              ]
            },
            {
              "_": "id 34, present",
              "job": [
                "id 164, present",
                "id 165, present"
              ]
            }
          ]
        },
        {
          "_": "id 168, present",
          "job": [
            {
              "_": "id 173, present",
              "queueable_job": [
                "id 59, present",
                "id 60, present"
              ]
            },
            "id 174, present"
          ],
          "stage": [
            {
              "_": "id 35, present",
              "job": [
                "id 169, present",
                "id 170, present"
              ]
            },
            {
              "_": "id 36, present",
              "job": [
                "id 171, present",
                "id 172, present"
              ]
            }
          ]
        },
        {
          "_": "id 175, present",
          "job": [
            {
              "_": "id 180, present",
              "queueable_job": [
                "id 61, present",
                "id 62, present"
              ]
            },
            "id 181, present"
          ],
          "repository": [
            "id 1, present, duplicate"
          ],
          "stage": [
            {
              "_": "id 37, present",
              "job": [
                "id 176, present",
                "id 177, present"
              ]
            },
            {
              "_": "id 38, present",
              "job": [
                "id 178, present",
                "id 179, present"
              ]
            }
          ]
        }
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
              "_": "id 54, removed",
              "queueable_job": [
                "id 17, removed",
                "id 18, removed"
              ]
            },
            "id 55, removed"
          ],
          "build": [
            {
              "_": "id 51, removed",
              "job": [
                "id 52, removed"
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
                "id 11, removed"
              ]
            },
            "id 53, removed"
          ]
        },
        "id 12, removed",
        "id 35, removed",
        "id 36, present"
      ],
      "job": [
        {
          "_": "id 56, present",
          "queueable_job": [
            "id 19, present",
            "id 20, present"
          ]
        },
        "id 57, present"
      ],
      "branch": [
        {
          "_": "id 14, present",
          "build": [
            {
              "_": "id 58, present",
              "job": [
                "id 59, present"
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
                "id 12, present"
              ]
            },
            "id 60, present"
          ],
          "commit": [
            {
              "_": "id 7, present",
              "build": [
                {
                  "_": "id 63, present",
                  "job": [
                    "id 64, present"
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
                    "id 13, present"
                  ]
                },
                "id 65, present"
              ],
              "job": [
                {
                  "_": "id 66, present",
                  "queueable_job": [
                    "id 23, present",
                    "id 24, present"
                  ]
                },
                "id 67, present"
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
                      "_": "id 71, present",
                      "queueable_job": [
                        "id 25, present",
                        "id 26, present"
                      ]
                    },
                    "id 72, present"
                  ],
                  "build": [
                    {
                      "_": "id 68, present",
                      "job": [
                        "id 69, present"
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
                        "id 14, present"
                      ]
                    },
                    "id 70, present"
                  ]
                },
                "id 14, present"
              ]
            },
            "id 8, present"
          ],
          "cron": [
            "id 2, present"
          ],
          "job": [
            {
              "_": "id 61, present",
              "queueable_job": [
                "id 21, present",
                "id 22, present"
              ]
            },
            "id 62, present"
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
                  "_": "id 76, present",
                  "queueable_job": [
                    "id 27, present",
                    "id 28, present"
                  ]
                },
                "id 77, present"
              ],
              "build": [
                {
                  "_": "id 73, present",
                  "job": [
                    "id 74, present"
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
                    "id 15, present"
                  ]
                },
                "id 75, present"
              ]
            },
            "id 16, present"
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
              "_": "id 78, present",
              "job": [
                "id 79, present"
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
                "id 16, present"
              ]
            },
            "id 80, present"
          ],
          "job": [
            {
              "_": "id 81, present",
              "queueable_job": [
                "id 29, present",
                "id 30, present"
              ]
            },
            "id 82, present"
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
                  "_": "id 86, present",
                  "queueable_job": [
                    "id 31, present",
                    "id 32, present"
                  ]
                },
                "id 87, present"
              ],
              "build": [
                {
                  "_": "id 83, present",
                  "job": [
                    "id 84, present"
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
                    "id 17, present"
                  ]
                },
                "id 85, present"
              ]
            },
            "id 18, present"
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
                  "_": "id 141, present",
                  "queueable_job": [
                    "id 49, present",
                    "id 50, present"
                  ]
                },
                "id 142, present"
              ],
              "build": [
                {
                  "_": "id 138, present",
                  "job": [
                    "id 139, present"
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
                    "id 28, present"
                  ]
                },
                "id 140, present"
              ]
            },
            "id 30, present"
          ],
          "build": [
            {
              "_": "id 88, present",
              "job": [
                {
                  "_": "id 93, present",
                  "queueable_job": [
                    "id 33, present",
                    "id 34, present"
                  ]
                },
                "id 94, present"
              ],
              "repository": [
                {
                  "_": "id 54, present",
                  "build": [
                    "id 135, present"
                  ],
                  "request": [
                    "id 28, present"
                  ],
                  "job": [
                    "id 136, present"
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
                    "id 133, present"
                  ],
                  "request": [
                    "id 27, present"
                  ],
                  "job": [
                    "id 134, present"
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
                      "_": "id 95, present",
                      "job": [
                        "id 96, present"
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
                        "id 20, present"
                      ]
                    },
                    "id 97, present"
                  ],
                  "commit": [
                    {
                      "_": "id 11, present",
                      "build": [
                        {
                          "_": "id 98, present",
                          "job": [
                            "id 99, present"
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
                            "id 21, present"
                          ]
                        },
                        "id 100, present"
                      ],
                      "job": [
                        {
                          "_": "id 101, present",
                          "queueable_job": [
                            "id 35, present",
                            "id 36, present"
                          ]
                        },
                        "id 102, present"
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
                              "_": "id 106, present",
                              "queueable_job": [
                                "id 37, present",
                                "id 38, present"
                              ]
                            },
                            "id 107, present"
                          ],
                          "build": [
                            {
                              "_": "id 103, present",
                              "job": [
                                "id 104, present"
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
                                "id 22, present"
                              ]
                            },
                            "id 105, present"
                          ]
                        },
                        "id 20, present"
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
                          "_": "id 111, present",
                          "queueable_job": [
                            "id 39, present",
                            "id 40, present"
                          ]
                        },
                        "id 112, present"
                      ],
                      "build": [
                        {
                          "_": "id 108, present",
                          "job": [
                            "id 109, present"
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
                            "id 23, present"
                          ]
                        },
                        "id 110, present"
                      ]
                    },
                    "id 22, present"
                  ]
                },
                "id 25, present"
              ],
              "branch": [
                {
                  "_": "id 26, present",
                  "build": [
                    {
                      "_": "id 113, present",
                      "job": [
                        "id 114, present"
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
                        "id 24, present"
                      ]
                    },
                    "id 115, present"
                  ],
                  "commit": [
                    {
                      "_": "id 13, present",
                      "build": [
                        {
                          "_": "id 118, present",
                          "job": [
                            "id 119, present"
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
                            "id 25, present"
                          ]
                        },
                        "id 120, present"
                      ],
                      "job": [
                        {
                          "_": "id 121, present",
                          "queueable_job": [
                            "id 43, present",
                            "id 44, present"
                          ]
                        },
                        "id 122, present"
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
                              "_": "id 126, present",
                              "queueable_job": [
                                "id 45, present",
                                "id 46, present"
                              ]
                            },
                            "id 127, present"
                          ],
                          "build": [
                            {
                              "_": "id 123, present",
                              "job": [
                                "id 124, present"
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
                                "id 26, present"
                              ]
                            },
                            "id 125, present"
                          ]
                        },
                        "id 24, present"
                      ]
                    },
                    "id 14, present"
                  ],
                  "cron": [
                    "id 3, present"
                  ],
                  "job": [
                    {
                      "_": "id 116, present",
                      "queueable_job": [
                        "id 41, present",
                        "id 42, present"
                      ]
                    },
                    "id 117, present"
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
                          "_": "id 131, present",
                          "queueable_job": [
                            "id 47, present",
                            "id 48, present"
                          ]
                        },
                        "id 132, present"
                      ],
                      "build": [
                        {
                          "_": "id 128, present",
                          "job": [
                            "id 129, present"
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
                            "id 27, present"
                          ]
                        },
                        "id 130, present"
                      ]
                    },
                    "id 26, present"
                  ]
                },
                "id 31, present"
              ],
              "stage": [
                {
                  "_": "id 18, present",
                  "job": [
                    "id 89, present",
                    "id 90, present"
                  ]
                },
                {
                  "_": "id 19, present",
                  "job": [
                    "id 91, present",
                    "id 92, present"
                  ]
                }
              ]
            },
            "id 137, present"
          ]
        },
        "id 6, present"
      ],
      "tag": [
        {
          "_": "id 33, present",
          "build": [
            {
              "_": "id 143, present",
              "job": [
                "id 144, present"
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
                "id 29, present"
              ]
            },
            "id 145, present"
          ],
          "commit": [
            {
              "_": "id 17, present",
              "build": [
                {
                  "_": "id 146, present",
                  "job": [
                    "id 147, present"
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
                    "id 30, present"
                  ]
                },
                "id 148, present"
              ],
              "job": [
                {
                  "_": "id 149, present",
                  "queueable_job": [
                    "id 51, present",
                    "id 52, present"
                  ]
                },
                "id 150, present"
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
                      "_": "id 154, present",
                      "queueable_job": [
                        "id 53, present",
                        "id 54, present"
                      ]
                    },
                    "id 155, present"
                  ],
                  "build": [
                    {
                      "_": "id 151, present",
                      "job": [
                        "id 152, present"
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
                        "id 31, present"
                      ]
                    },
                    "id 153, present"
                  ]
                },
                "id 32, present"
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
                  "_": "id 159, present",
                  "queueable_job": [
                    "id 55, present",
                    "id 56, present"
                  ]
                },
                "id 160, present"
              ],
              "build": [
                {
                  "_": "id 156, present",
                  "job": [
                    "id 157, present"
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
                    "id 32, present"
                  ]
                },
                "id 158, present"
              ]
            },
            "id 34, present"
          ]
        },
        "id 38, present"
      ]
    }
  end
end