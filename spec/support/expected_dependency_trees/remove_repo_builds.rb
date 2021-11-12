class ExpectedDependencyTrees
  def self.remove_repo_builds
    {
      _: "id 1, present",
      build: [
        {
          _: "id 1, removed",
          job: [
            {
              _: "id 6, removed",
              log: [
                "id 1, removed",
                "id 2, removed"
              ],
              annotation: [
                "id 1, removed",
                "id 2, removed"
              ],
              queueable_job: [
                "id 1, removed",
                "id 2, removed"
              ]
            },
            "id 7, removed"
          ],
          repository: [
            {
              _: "id 20, present",
              build: [
                "id 48, present"
              ],
              request: [
                "id 10, present"
              ],
              job: [
                "id 49, present"
              ],
              branch: [
                "id 84, present"
              ],
              ssl_key: [
                "id 32, present"
              ],
              commit: [
                "id 216, present"
              ],
              permission: [
                "id 2, present"
              ],
              star: [
                "id 2, present"
              ],
              pull_request: [
                "id 2, present"
              ],
              tag: [
                "id 12, present"
              ]
            },
            "id 21, present",
            {
              _: "id 18, present",
              build: [
                "id 46, present"
              ],
              request: [
                "id 9, present"
              ],
              job: [
                "id 47, present"
              ],
              branch: [
                "id 83, present"
              ],
              ssl_key: [
                "id 31, present"
              ],
              commit: [
                "id 215, present"
              ],
              permission: [
                "id 1, present"
              ],
              star: [
                "id 1, present"
              ],
              pull_request: [
                "id 1, present"
              ],
              tag: [
                "id 11, present"
              ]
            },
            "id 19, present"
          ],
          tag: [
            {
              _: "id 1, present",
              build: [
                {
                  _: "id 8, present",
                  job: [
                    "id 9, present"
                  ],
                  repository: [
                    "id 3, present",
                    "id 2, present"
                  ],
                  tag: [
                    "id 2, present"
                  ],
                  branch: [
                    "id 73, present"
                  ],
                  stage: [
                    "id 22, present"
                  ]
                },
                "id 10, present"
              ],
              commit: [
                {
                  _: "id 211, present",
                  build: [
                    {
                      _: "id 11, present",
                      job: [
                        "id 12, present"
                      ],
                      repository: [
                        "id 5, present",
                        "id 4, present"
                      ],
                      tag: [
                        "id 3, present"
                      ],
                      branch: [
                        "id 74, present"
                      ],
                      stage: [
                        "id 23, present"
                      ]
                    },
                    "id 13, present"
                  ],
                  job: [
                    {
                      _: "id 14, present",
                      log: [
                        "id 3, present",
                        "id 4, present"
                      ],
                      annotation: [
                        "id 3, present",
                        "id 4, present"
                      ],
                      queueable_job: [
                        "id 3, present",
                        "id 4, present"
                      ]
                    },
                    "id 15, present"
                  ],
                  request: [
                    {
                      _: "id 1, present",
                      abuse: [
                        "id 1, present",
                        "id 2, present"
                      ],
                      message: [
                        "id 1, present",
                        "id 2, present"
                      ],
                      job: [
                        {
                          _: "id 19, present",
                          log: [
                            "id 5, present",
                            "id 6, present"
                          ],
                          annotation: [
                            "id 5, present",
                            "id 6, present"
                          ],
                          queueable_job: [
                            "id 5, present",
                            "id 6, present"
                          ]
                        },
                        "id 20, present"
                      ],
                      build: [
                        {
                          _: "id 16, present",
                          job: [
                            "id 17, present"
                          ],
                          repository: [
                            "id 7, present",
                            "id 6, present"
                          ],
                          tag: [
                            "id 4, present"
                          ],
                          branch: [
                            "id 75, present"
                          ],
                          stage: [
                            "id 24, present"
                          ]
                        },
                        "id 18, present"
                      ]
                    },
                    "id 2, present"
                  ]
                },
                "id 212, present"
              ],
              request: [
                {
                  _: "id 3, present",
                  abuse: [
                    "id 3, present",
                    "id 4, present"
                  ],
                  message: [
                    "id 3, present",
                    "id 4, present"
                  ],
                  job: [
                    {
                      _: "id 24, present",
                      log: [
                        "id 7, present",
                        "id 8, present"
                      ],
                      annotation: [
                        "id 7, present",
                        "id 8, present"
                      ],
                      queueable_job: [
                        "id 7, present",
                        "id 8, present"
                      ]
                    },
                    "id 25, present"
                  ],
                  build: [
                    {
                      _: "id 21, present",
                      job: [
                        "id 22, present"
                      ],
                      repository: [
                        "id 9, present",
                        "id 8, present"
                      ],
                      tag: [
                        "id 5, present"
                      ],
                      branch: [
                        "id 76, present"
                      ],
                      stage: [
                        "id 25, present"
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
          branch: [
            {
              _: "id 77, present",
              build: [
                {
                  _: "id 26, present",
                  job: [
                    "id 27, present"
                  ],
                  repository: [
                    "id 11, present",
                    "id 10, present"
                  ],
                  tag: [
                    "id 7, present"
                  ],
                  branch: [
                    "id 78, present"
                  ],
                  stage: [
                    "id 26, present"
                  ]
                },
                "id 28, present"
              ],
              commit: [
                {
                  _: "id 213, present",
                  build: [
                    {
                      _: "id 31, present",
                      job: [
                        "id 32, present"
                      ],
                      repository: [
                        "id 13, present",
                        "id 12, present"
                      ],
                      tag: [
                        "id 8, present"
                      ],
                      branch: [
                        "id 79, present"
                      ],
                      stage: [
                        "id 27, present"
                      ]
                    },
                    "id 33, present"
                  ],
                  job: [
                    {
                      _: "id 34, present",
                      log: [
                        "id 11, present",
                        "id 12, present"
                      ],
                      annotation: [
                        "id 11, present",
                        "id 12, present"
                      ],
                      queueable_job: [
                        "id 11, present",
                        "id 12, present"
                      ]
                    },
                    "id 35, present"
                  ],
                  request: [
                    {
                      _: "id 5, present",
                      abuse: [
                        "id 5, present",
                        "id 6, present"
                      ],
                      message: [
                        "id 5, present",
                        "id 6, present"
                      ],
                      job: [
                        {
                          _: "id 39, present",
                          log: [
                            "id 13, present",
                            "id 14, present"
                          ],
                          annotation: [
                            "id 13, present",
                            "id 14, present"
                          ],
                          queueable_job: [
                            "id 13, present",
                            "id 14, present"
                          ]
                        },
                        "id 40, present"
                      ],
                      build: [
                        {
                          _: "id 36, present",
                          job: [
                            "id 37, present"
                          ],
                          repository: [
                            "id 15, present",
                            "id 14, present"
                          ],
                          tag: [
                            "id 9, present"
                          ],
                          branch: [
                            "id 80, present"
                          ],
                          stage: [
                            "id 28, present"
                          ]
                        },
                        "id 38, present"
                      ]
                    },
                    "id 6, present"
                  ]
                },
                "id 214, present"
              ],
              cron: [
                "id 1, present",
                "id 2, present"
              ],
              job: [
                {
                  _: "id 29, present",
                  log: [
                    "id 9, present",
                    "id 10, present"
                  ],
                  annotation: [
                    "id 9, present",
                    "id 10, present"
                  ],
                  queueable_job: [
                    "id 9, present",
                    "id 10, present"
                  ]
                },
                "id 30, present"
              ],
              request: [
                {
                  _: "id 7, present",
                  abuse: [
                    "id 7, present",
                    "id 8, present"
                  ],
                  message: [
                    "id 7, present",
                    "id 8, present"
                  ],
                  job: [
                    {
                      _: "id 44, present",
                      log: [
                        "id 15, present",
                        "id 16, present"
                      ],
                      annotation: [
                        "id 15, present",
                        "id 16, present"
                      ],
                      queueable_job: [
                        "id 15, present",
                        "id 16, present"
                      ]
                    },
                    "id 45, present"
                  ],
                  build: [
                    {
                      _: "id 41, present",
                      job: [
                        "id 42, present"
                      ],
                      repository: [
                        "id 17, present",
                        "id 16, present"
                      ],
                      tag: [
                        "id 10, present"
                      ],
                      branch: [
                        "id 81, present"
                      ],
                      stage: [
                        "id 29, present"
                      ]
                    },
                    "id 43, present"
                  ]
                },
                "id 8, present"
              ]
            },
            "id 82, present"
          ],
          stage: [
            {
              _: "id 20, removed",
              job: [
                "id 2, removed",
                "id 3, removed"
              ]
            },
            {
              _: "id 21, removed",
              job: [
                "id 4, removed",
                "id 5, removed"
              ]
            }
          ]
        },
        "id 50, removed",
        {
          _: "id 161, removed",
          job: [
            {
              _: "id 166, removed",
              log: [
                "id 57, removed",
                "id 58, removed"
              ],
              annotation: [
                "id 57, removed",
                "id 58, removed"
              ],
              queueable_job: [
                "id 57, removed",
                "id 58, removed"
              ]
            },
            "id 167, removed"
          ],
          stage: [
            {
              _: "id 52, removed",
              job: [
                "id 162, removed",
                "id 163, removed"
              ]
            },
            {
              _: "id 53, removed",
              job: [
                "id 164, removed",
                "id 165, removed"
              ]
            }
          ]
        },
        {
          _: "id 168, present",
          job: [
            {
              _: "id 173, present",
              log: [
                "id 59, present",
                "id 60, present"
              ],
              annotation: [
                "id 59, present",
                "id 60, present"
              ],
              queueable_job: [
                "id 59, present",
                "id 60, present"
              ]
            },
            "id 174, present"
          ],
          stage: [
            {
              _: "id 54, present",
              job: [
                "id 169, present",
                "id 170, present"
              ]
            },
            {
              _: "id 55, present",
              job: [
                "id 171, present",
                "id 172, present"
              ]
            }
          ]
        },
        {
          _: "id 175, removed",
          job: [
            {
              _: "id 180, removed",
              log: [
                "id 61, removed",
                "id 62, removed"
              ],
              annotation: [
                "id 61, removed",
                "id 62, removed"
              ],
              queueable_job: [
                "id 61, removed",
                "id 62, removed"
              ]
            },
            "id 181, removed"
          ],
          repository: [
            "id 1, present, duplicate"
          ],
          stage: [
            {
              _: "id 56, removed",
              job: [
                "id 176, removed",
                "id 177, removed"
              ]
            },
            {
              _: "id 57, removed",
              job: [
                "id 178, removed",
                "id 179, removed"
              ]
            }
          ]
        }
      ],
      request: [
        {
          _: "id 11, present",
          abuse: [
            "id 9, present",
            "id 10, present"
          ],
          message: [
            "id 9, present",
            "id 10, present"
          ],
          job: [
            {
              _: "id 54, present",
              log: [
                "id 17, present",
                "id 18, present"
              ],
              annotation: [
                "id 17, present",
                "id 18, present"
              ],
              queueable_job: [
                "id 17, present",
                "id 18, present"
              ]
            },
            "id 55, present"
          ],
          build: [
            {
              _: "id 51, present",
              job: [
                "id 52, present"
              ],
              repository: [
                "id 23, present",
                "id 22, present"
              ],
              tag: [
                "id 13, present"
              ],
              branch: [
                "id 85, present"
              ],
              stage: [
                "id 30, present"
              ]
            },
            "id 53, present"
          ]
        },
        "id 12, present",
        "id 35, present",
        "id 36, present"
      ],
      job: [
        {
          _: "id 56, present",
          log: [
            "id 19, present",
            "id 20, present"
          ],
          annotation: [
            "id 19, present",
            "id 20, present"
          ],
          queueable_job: [
            "id 19, present",
            "id 20, present"
          ]
        },
        "id 57, present"
      ],
      branch: [
        {
          _: "id 86, present",
          build: [
            {
              _: "id 58, present",
              job: [
                "id 59, present"
              ],
              repository: [
                "id 25, present",
                "id 24, present"
              ],
              tag: [
                "id 14, present"
              ],
              branch: [
                "id 87, present"
              ],
              stage: [
                "id 31, present"
              ]
            },
            "id 60, present"
          ],
          commit: [
            {
              _: "id 217, present",
              build: [
                {
                  _: "id 63, present",
                  job: [
                    "id 64, present"
                  ],
                  repository: [
                    "id 27, present",
                    "id 26, present"
                  ],
                  tag: [
                    "id 15, present"
                  ],
                  branch: [
                    "id 88, present"
                  ],
                  stage: [
                    "id 32, present"
                  ]
                },
                "id 65, present"
              ],
              job: [
                {
                  _: "id 66, present",
                  log: [
                    "id 23, present",
                    "id 24, present"
                  ],
                  annotation: [
                    "id 23, present",
                    "id 24, present"
                  ],
                  queueable_job: [
                    "id 23, present",
                    "id 24, present"
                  ]
                },
                "id 67, present"
              ],
              request: [
                {
                  _: "id 13, present",
                  abuse: [
                    "id 11, present",
                    "id 12, present"
                  ],
                  message: [
                    "id 11, present",
                    "id 12, present"
                  ],
                  job: [
                    {
                      _: "id 71, present",
                      log: [
                        "id 25, present",
                        "id 26, present"
                      ],
                      annotation: [
                        "id 25, present",
                        "id 26, present"
                      ],
                      queueable_job: [
                        "id 25, present",
                        "id 26, present"
                      ]
                    },
                    "id 72, present"
                  ],
                  build: [
                    {
                      _: "id 68, present",
                      job: [
                        "id 69, present"
                      ],
                      repository: [
                        "id 29, present",
                        "id 28, present"
                      ],
                      tag: [
                        "id 16, present"
                      ],
                      branch: [
                        "id 89, present"
                      ],
                      stage: [
                        "id 33, present"
                      ]
                    },
                    "id 70, present"
                  ]
                },
                "id 14, present"
              ]
            },
            "id 218, present"
          ],
          cron: [
            "id 3, present",
            "id 4, present"
          ],
          job: [
            {
              _: "id 61, present",
              log: [
                "id 21, present",
                "id 22, present"
              ],
              annotation: [
                "id 21, present",
                "id 22, present"
              ],
              queueable_job: [
                "id 21, present",
                "id 22, present"
              ]
            },
            "id 62, present"
          ],
          request: [
            {
              _: "id 15, present",
              abuse: [
                "id 13, present",
                "id 14, present"
              ],
              message: [
                "id 13, present",
                "id 14, present"
              ],
              job: [
                {
                  _: "id 76, present",
                  log: [
                    "id 27, present",
                    "id 28, present"
                  ],
                  annotation: [
                    "id 27, present",
                    "id 28, present"
                  ],
                  queueable_job: [
                    "id 27, present",
                    "id 28, present"
                  ]
                },
                "id 77, present"
              ],
              build: [
                {
                  _: "id 73, present",
                  job: [
                    "id 74, present"
                  ],
                  repository: [
                    "id 31, present",
                    "id 30, present"
                  ],
                  tag: [
                    "id 17, present"
                  ],
                  branch: [
                    "id 90, present"
                  ],
                  stage: [
                    "id 34, present"
                  ]
                },
                "id 75, present"
              ]
            },
            "id 16, present"
          ]
        },
        "id 91, present"
      ],
      ssl_key: [
        "id 33, present",
        "id 34, present"
      ],
      commit: [
        {
          _: "id 219, present",
          build: [
            {
              _: "id 78, present",
              job: [
                "id 79, present"
              ],
              repository: [
                "id 33, present",
                "id 32, present"
              ],
              tag: [
                "id 18, present"
              ],
              branch: [
                "id 92, present"
              ],
              stage: [
                "id 35, present"
              ]
            },
            "id 80, present"
          ],
          job: [
            {
              _: "id 81, present",
              log: [
                "id 29, present",
                "id 30, present"
              ],
              annotation: [
                "id 29, present",
                "id 30, present"
              ],
              queueable_job: [
                "id 29, present",
                "id 30, present"
              ]
            },
            "id 82, present"
          ],
          request: [
            {
              _: "id 17, present",
              abuse: [
                "id 15, present",
                "id 16, present"
              ],
              message: [
                "id 15, present",
                "id 16, present"
              ],
              job: [
                {
                  _: "id 86, present",
                  log: [
                    "id 31, present",
                    "id 32, present"
                  ],
                  annotation: [
                    "id 31, present",
                    "id 32, present"
                  ],
                  queueable_job: [
                    "id 31, present",
                    "id 32, present"
                  ]
                },
                "id 87, present"
              ],
              build: [
                {
                  _: "id 83, present",
                  job: [
                    "id 84, present"
                  ],
                  repository: [
                    "id 35, present",
                    "id 34, present"
                  ],
                  tag: [
                    "id 19, present"
                  ],
                  branch: [
                    "id 93, present"
                  ],
                  stage: [
                    "id 36, present"
                  ]
                },
                "id 85, present"
              ]
            },
            "id 18, present"
          ]
        },
        "id 220, present"
      ],
      permission: [
        "id 3, present",
        "id 4, present"
      ],
      star: [
        "id 3, present",
        "id 4, present"
      ],
      pull_request: [
        {
          _: "id 3, present",
          request: [
            {
              _: "id 29, present",
              abuse: [
                "id 25, present",
                "id 26, present"
              ],
              message: [
                "id 25, present",
                "id 26, present"
              ],
              job: [
                {
                  _: "id 141, present",
                  log: [
                    "id 49, present",
                    "id 50, present"
                  ],
                  annotation: [
                    "id 49, present",
                    "id 50, present"
                  ],
                  queueable_job: [
                    "id 49, present",
                    "id 50, present"
                  ]
                },
                "id 142, present"
              ],
              build: [
                {
                  _: "id 138, present",
                  job: [
                    "id 139, present"
                  ],
                  repository: [
                    "id 57, present",
                    "id 56, present"
                  ],
                  tag: [
                    "id 32, present"
                  ],
                  branch: [
                    "id 106, present"
                  ],
                  stage: [
                    "id 47, present"
                  ]
                },
                "id 140, present"
              ]
            },
            "id 30, present"
          ],
          build: [
            {
              _: "id 88, present",
              job: [
                {
                  _: "id 93, present",
                  log: [
                    "id 33, present",
                    "id 34, present"
                  ],
                  annotation: [
                    "id 33, present",
                    "id 34, present"
                  ],
                  queueable_job: [
                    "id 33, present",
                    "id 34, present"
                  ]
                },
                "id 94, present"
              ],
              repository: [
                {
                  _: "id 54, present",
                  build: [
                    "id 135, present"
                  ],
                  request: [
                    "id 28, present"
                  ],
                  job: [
                    "id 136, present"
                  ],
                  branch: [
                    "id 105, present"
                  ],
                  ssl_key: [
                    "id 36, present"
                  ],
                  commit: [
                    "id 226, present"
                  ],
                  permission: [
                    "id 6, present"
                  ],
                  star: [
                    "id 6, present"
                  ],
                  pull_request: [
                    "id 5, present"
                  ],
                  tag: [
                    "id 31, present"
                  ]
                },
                "id 55, present",
                {
                  _: "id 52, present",
                  build: [
                    "id 133, present"
                  ],
                  request: [
                    "id 27, present"
                  ],
                  job: [
                    "id 134, present"
                  ],
                  branch: [
                    "id 104, present"
                  ],
                  ssl_key: [
                    "id 35, present"
                  ],
                  commit: [
                    "id 225, present"
                  ],
                  permission: [
                    "id 5, present"
                  ],
                  star: [
                    "id 5, present"
                  ],
                  pull_request: [
                    "id 4, present"
                  ],
                  tag: [
                    "id 30, present"
                  ]
                },
                "id 53, present"
              ],
              tag: [
                {
                  _: "id 20, present",
                  build: [
                    {
                      _: "id 95, present",
                      job: [
                        "id 96, present"
                      ],
                      repository: [
                        "id 37, present",
                        "id 36, present"
                      ],
                      tag: [
                        "id 21, present"
                      ],
                      branch: [
                        "id 94, present"
                      ],
                      stage: [
                        "id 39, present"
                      ]
                    },
                    "id 97, present"
                  ],
                  commit: [
                    {
                      _: "id 221, present",
                      build: [
                        {
                          _: "id 98, present",
                          job: [
                            "id 99, present"
                          ],
                          repository: [
                            "id 39, present",
                            "id 38, present"
                          ],
                          tag: [
                            "id 22, present"
                          ],
                          branch: [
                            "id 95, present"
                          ],
                          stage: [
                            "id 40, present"
                          ]
                        },
                        "id 100, present"
                      ],
                      job: [
                        {
                          _: "id 101, present",
                          log: [
                            "id 35, present",
                            "id 36, present"
                          ],
                          annotation: [
                            "id 35, present",
                            "id 36, present"
                          ],
                          queueable_job: [
                            "id 35, present",
                            "id 36, present"
                          ]
                        },
                        "id 102, present"
                      ],
                      request: [
                        {
                          _: "id 19, present",
                          abuse: [
                            "id 17, present",
                            "id 18, present"
                          ],
                          message: [
                            "id 17, present",
                            "id 18, present"
                          ],
                          job: [
                            {
                              _: "id 106, present",
                              log: [
                                "id 37, present",
                                "id 38, present"
                              ],
                              annotation: [
                                "id 37, present",
                                "id 38, present"
                              ],
                              queueable_job: [
                                "id 37, present",
                                "id 38, present"
                              ]
                            },
                            "id 107, present"
                          ],
                          build: [
                            {
                              _: "id 103, present",
                              job: [
                                "id 104, present"
                              ],
                              repository: [
                                "id 41, present",
                                "id 40, present"
                              ],
                              tag: [
                                "id 23, present"
                              ],
                              branch: [
                                "id 96, present"
                              ],
                              stage: [
                                "id 41, present"
                              ]
                            },
                            "id 105, present"
                          ]
                        },
                        "id 20, present"
                      ]
                    },
                    "id 222, present"
                  ],
                  request: [
                    {
                      _: "id 21, present",
                      abuse: [
                        "id 19, present",
                        "id 20, present"
                      ],
                      message: [
                        "id 19, present",
                        "id 20, present"
                      ],
                      job: [
                        {
                          _: "id 111, present",
                          log: [
                            "id 39, present",
                            "id 40, present"
                          ],
                          annotation: [
                            "id 39, present",
                            "id 40, present"
                          ],
                          queueable_job: [
                            "id 39, present",
                            "id 40, present"
                          ]
                        },
                        "id 112, present"
                      ],
                      build: [
                        {
                          _: "id 108, present",
                          job: [
                            "id 109, present"
                          ],
                          repository: [
                            "id 43, present",
                            "id 42, present"
                          ],
                          tag: [
                            "id 24, present"
                          ],
                          branch: [
                            "id 97, present"
                          ],
                          stage: [
                            "id 42, present"
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
              branch: [
                {
                  _: "id 98, present",
                  build: [
                    {
                      _: "id 113, present",
                      job: [
                        "id 114, present"
                      ],
                      repository: [
                        "id 45, present",
                        "id 44, present"
                      ],
                      tag: [
                        "id 26, present"
                      ],
                      branch: [
                        "id 99, present"
                      ],
                      stage: [
                        "id 43, present"
                      ]
                    },
                    "id 115, present"
                  ],
                  commit: [
                    {
                      _: "id 223, present",
                      build: [
                        {
                          _: "id 118, present",
                          job: [
                            "id 119, present"
                          ],
                          repository: [
                            "id 47, present",
                            "id 46, present"
                          ],
                          tag: [
                            "id 27, present"
                          ],
                          branch: [
                            "id 100, present"
                          ],
                          stage: [
                            "id 44, present"
                          ]
                        },
                        "id 120, present"
                      ],
                      job: [
                        {
                          _: "id 121, present",
                          log: [
                            "id 43, present",
                            "id 44, present"
                          ],
                          annotation: [
                            "id 43, present",
                            "id 44, present"
                          ],
                          queueable_job: [
                            "id 43, present",
                            "id 44, present"
                          ]
                        },
                        "id 122, present"
                      ],
                      request: [
                        {
                          _: "id 23, present",
                          abuse: [
                            "id 21, present",
                            "id 22, present"
                          ],
                          message: [
                            "id 21, present",
                            "id 22, present"
                          ],
                          job: [
                            {
                              _: "id 126, present",
                              log: [
                                "id 45, present",
                                "id 46, present"
                              ],
                              annotation: [
                                "id 45, present",
                                "id 46, present"
                              ],
                              queueable_job: [
                                "id 45, present",
                                "id 46, present"
                              ]
                            },
                            "id 127, present"
                          ],
                          build: [
                            {
                              _: "id 123, present",
                              job: [
                                "id 124, present"
                              ],
                              repository: [
                                "id 49, present",
                                "id 48, present"
                              ],
                              tag: [
                                "id 28, present"
                              ],
                              branch: [
                                "id 101, present"
                              ],
                              stage: [
                                "id 45, present"
                              ]
                            },
                            "id 125, present"
                          ]
                        },
                        "id 24, present"
                      ]
                    },
                    "id 224, present"
                  ],
                  cron: [
                    "id 5, present",
                    "id 6, present"
                  ],
                  job: [
                    {
                      _: "id 116, present",
                      log: [
                        "id 41, present",
                        "id 42, present"
                      ],
                      annotation: [
                        "id 41, present",
                        "id 42, present"
                      ],
                      queueable_job: [
                        "id 41, present",
                        "id 42, present"
                      ]
                    },
                    "id 117, present"
                  ],
                  request: [
                    {
                      _: "id 25, present",
                      abuse: [
                        "id 23, present",
                        "id 24, present"
                      ],
                      message: [
                        "id 23, present",
                        "id 24, present"
                      ],
                      job: [
                        {
                          _: "id 131, present",
                          log: [
                            "id 47, present",
                            "id 48, present"
                          ],
                          annotation: [
                            "id 47, present",
                            "id 48, present"
                          ],
                          queueable_job: [
                            "id 47, present",
                            "id 48, present"
                          ]
                        },
                        "id 132, present"
                      ],
                      build: [
                        {
                          _: "id 128, present",
                          job: [
                            "id 129, present"
                          ],
                          repository: [
                            "id 51, present",
                            "id 50, present"
                          ],
                          tag: [
                            "id 29, present"
                          ],
                          branch: [
                            "id 102, present"
                          ],
                          stage: [
                            "id 46, present"
                          ]
                        },
                        "id 130, present"
                      ]
                    },
                    "id 26, present"
                  ]
                },
                "id 103, present"
              ],
              stage: [
                {
                  _: "id 37, present",
                  job: [
                    "id 89, present",
                    "id 90, present"
                  ]
                },
                {
                  _: "id 38, present",
                  job: [
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
      tag: [
        {
          _: "id 33, present",
          build: [
            {
              _: "id 143, present",
              job: [
                "id 144, present"
              ],
              repository: [
                "id 59, present",
                "id 58, present"
              ],
              tag: [
                "id 34, present"
              ],
              branch: [
                "id 107, present"
              ],
              stage: [
                "id 48, present"
              ]
            },
            "id 145, present"
          ],
          commit: [
            {
              _: "id 227, present",
              build: [
                {
                  _: "id 146, present",
                  job: [
                    "id 147, present"
                  ],
                  repository: [
                    "id 61, present",
                    "id 60, present"
                  ],
                  tag: [
                    "id 35, present"
                  ],
                  branch: [
                    "id 108, present"
                  ],
                  stage: [
                    "id 49, present"
                  ]
                },
                "id 148, present"
              ],
              job: [
                {
                  _: "id 149, present",
                  log: [
                    "id 51, present",
                    "id 52, present"
                  ],
                  annotation: [
                    "id 51, present",
                    "id 52, present"
                  ],
                  queueable_job: [
                    "id 51, present",
                    "id 52, present"
                  ]
                },
                "id 150, present"
              ],
              request: [
                {
                  _: "id 31, present",
                  abuse: [
                    "id 27, present",
                    "id 28, present"
                  ],
                  message: [
                    "id 27, present",
                    "id 28, present"
                  ],
                  job: [
                    {
                      _: "id 154, present",
                      log: [
                        "id 53, present",
                        "id 54, present"
                      ],
                      annotation: [
                        "id 53, present",
                        "id 54, present"
                      ],
                      queueable_job: [
                        "id 53, present",
                        "id 54, present"
                      ]
                    },
                    "id 155, present"
                  ],
                  build: [
                    {
                      _: "id 151, present",
                      job: [
                        "id 152, present"
                      ],
                      repository: [
                        "id 63, present",
                        "id 62, present"
                      ],
                      tag: [
                        "id 36, present"
                      ],
                      branch: [
                        "id 109, present"
                      ],
                      stage: [
                        "id 50, present"
                      ]
                    },
                    "id 153, present"
                  ]
                },
                "id 32, present"
              ]
            },
            "id 228, present"
          ],
          request: [
            {
              _: "id 33, present",
              abuse: [
                "id 29, present",
                "id 30, present"
              ],
              message: [
                "id 29, present",
                "id 30, present"
              ],
              job: [
                {
                  _: "id 159, present",
                  log: [
                    "id 55, present",
                    "id 56, present"
                  ],
                  annotation: [
                    "id 55, present",
                    "id 56, present"
                  ],
                  queueable_job: [
                    "id 55, present",
                    "id 56, present"
                  ]
                },
                "id 160, present"
              ],
              build: [
                {
                  _: "id 156, present",
                  job: [
                    "id 157, present"
                  ],
                  repository: [
                    "id 65, present",
                    "id 64, present"
                  ],
                  tag: [
                    "id 37, present"
                  ],
                  branch: [
                    "id 110, present"
                  ],
                  stage: [
                    "id 51, present"
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