class ExpectedDependencyTrees
  def self.remove_repo_with_dependencies
    {
      _: "id 1, removed",
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
        "id 50, removed"
      ],
      request: [
        {
          _: "id 11, removed",
          abuse: [
            "id 9, removed",
            "id 10, removed"
          ],
          message: [
            "id 9, removed",
            "id 10, removed"
          ],
          job: [
            {
              _: "id 54, removed",
              log: [
                "id 17, removed",
                "id 18, removed"
              ],
              annotation: [
                "id 17, removed",
                "id 18, removed"
              ],
              queueable_job: [
                "id 17, removed",
                "id 18, removed"
              ]
            },
            "id 55, removed"
          ],
          build: [
            {
              _: "id 51, removed",
              job: [
                "id 52, removed"
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
                "id 30, removed"
              ]
            },
            "id 53, removed"
          ]
        },
        "id 12, removed"
      ],
      job: [
        {
          _: "id 56, removed",
          log: [
            "id 19, removed",
            "id 20, removed"
          ],
          annotation: [
            "id 19, removed",
            "id 20, removed"
          ],
          queueable_job: [
            "id 19, removed",
            "id 20, removed"
          ]
        },
        "id 57, removed"
      ],
      branch: [
        {
          _: "id 86, removed",
          build: [
            {
              _: "id 58, removed",
              job: [
                "id 59, removed"
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
                "id 31, removed"
              ]
            },
            "id 60, removed"
          ],
          commit: [
            {
              _: "id 217, removed",
              build: [
                {
                  _: "id 63, removed",
                  job: [
                    "id 64, removed"
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
                    "id 32, removed"
                  ]
                },
                "id 65, removed"
              ],
              job: [
                {
                  _: "id 66, removed",
                  log: [
                    "id 23, removed",
                    "id 24, removed"
                  ],
                  annotation: [
                    "id 23, removed",
                    "id 24, removed"
                  ],
                  queueable_job: [
                    "id 23, removed",
                    "id 24, removed"
                  ]
                },
                "id 67, removed"
              ],
              request: [
                {
                  _: "id 13, removed",
                  abuse: [
                    "id 11, removed",
                    "id 12, removed"
                  ],
                  message: [
                    "id 11, removed",
                    "id 12, removed"
                  ],
                  job: [
                    {
                      _: "id 71, removed",
                      log: [
                        "id 25, removed",
                        "id 26, removed"
                      ],
                      annotation: [
                        "id 25, removed",
                        "id 26, removed"
                      ],
                      queueable_job: [
                        "id 25, removed",
                        "id 26, removed"
                      ]
                    },
                    "id 72, removed"
                  ],
                  build: [
                    {
                      _: "id 68, removed",
                      job: [
                        "id 69, removed"
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
                        "id 33, removed"
                      ]
                    },
                    "id 70, removed"
                  ]
                },
                "id 14, removed"
              ]
            },
            "id 218, removed"
          ],
          cron: [
            "id 3, removed",
            "id 4, removed"
          ],
          job: [
            {
              _: "id 61, removed",
              log: [
                "id 21, removed",
                "id 22, removed"
              ],
              annotation: [
                "id 21, removed",
                "id 22, removed"
              ],
              queueable_job: [
                "id 21, removed",
                "id 22, removed"
              ]
            },
            "id 62, removed"
          ],
          request: [
            {
              _: "id 15, removed",
              abuse: [
                "id 13, removed",
                "id 14, removed"
              ],
              message: [
                "id 13, removed",
                "id 14, removed"
              ],
              job: [
                {
                  _: "id 76, removed",
                  log: [
                    "id 27, removed",
                    "id 28, removed"
                  ],
                  annotation: [
                    "id 27, removed",
                    "id 28, removed"
                  ],
                  queueable_job: [
                    "id 27, removed",
                    "id 28, removed"
                  ]
                },
                "id 77, removed"
              ],
              build: [
                {
                  _: "id 73, removed",
                  job: [
                    "id 74, removed"
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
                    "id 34, removed"
                  ]
                },
                "id 75, removed"
              ]
            },
            "id 16, removed"
          ]
        },
        "id 91, removed"
      ],
      ssl_key: [
        "id 33, removed",
        "id 34, removed"
      ],
      commit: [
        {
          _: "id 219, removed",
          build: [
            {
              _: "id 78, removed",
              job: [
                "id 79, removed"
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
                "id 35, removed"
              ]
            },
            "id 80, removed"
          ],
          job: [
            {
              _: "id 81, removed",
              log: [
                "id 29, removed",
                "id 30, removed"
              ],
              annotation: [
                "id 29, removed",
                "id 30, removed"
              ],
              queueable_job: [
                "id 29, removed",
                "id 30, removed"
              ]
            },
            "id 82, removed"
          ],
          request: [
            {
              _: "id 17, removed",
              abuse: [
                "id 15, removed",
                "id 16, removed"
              ],
              message: [
                "id 15, removed",
                "id 16, removed"
              ],
              job: [
                {
                  _: "id 86, removed",
                  log: [
                    "id 31, removed",
                    "id 32, removed"
                  ],
                  annotation: [
                    "id 31, removed",
                    "id 32, removed"
                  ],
                  queueable_job: [
                    "id 31, removed",
                    "id 32, removed"
                  ]
                },
                "id 87, removed"
              ],
              build: [
                {
                  _: "id 83, removed",
                  job: [
                    "id 84, removed"
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
                    "id 36, removed"
                  ]
                },
                "id 85, removed"
              ]
            },
            "id 18, removed"
          ]
        },
        "id 220, removed"
      ],
      permission: [
        "id 3, removed",
        "id 4, removed"
      ],
      star: [
        "id 3, removed",
        "id 4, removed"
      ],
      pull_request: [
        {
          _: "id 3, removed",
          request: [
            {
              _: "id 29, removed",
              abuse: [
                "id 25, removed",
                "id 26, removed"
              ],
              message: [
                "id 25, removed",
                "id 26, removed"
              ],
              job: [
                {
                  _: "id 141, removed",
                  log: [
                    "id 49, removed",
                    "id 50, removed"
                  ],
                  annotation: [
                    "id 49, removed",
                    "id 50, removed"
                  ],
                  queueable_job: [
                    "id 49, removed",
                    "id 50, removed"
                  ]
                },
                "id 142, removed"
              ],
              build: [
                {
                  _: "id 138, removed",
                  job: [
                    "id 139, removed"
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
                    "id 47, removed"
                  ]
                },
                "id 140, removed"
              ]
            },
            "id 30, removed"
          ],
          build: [
            {
              _: "id 88, removed",
              job: [
                {
                  _: "id 93, removed",
                  log: [
                    "id 33, removed",
                    "id 34, removed"
                  ],
                  annotation: [
                    "id 33, removed",
                    "id 34, removed"
                  ],
                  queueable_job: [
                    "id 33, removed",
                    "id 34, removed"
                  ]
                },
                "id 94, removed"
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
                  _: "id 37, removed",
                  job: [
                    "id 89, removed",
                    "id 90, removed"
                  ]
                },
                {
                  _: "id 38, removed",
                  job: [
                    "id 91, removed",
                    "id 92, removed"
                  ]
                }
              ]
            },
            "id 137, removed"
          ]
        },
        "id 6, removed"
      ],
      tag: [
        {
          _: "id 33, removed",
          build: [
            {
              _: "id 143, removed",
              job: [
                "id 144, removed"
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
                "id 48, removed"
              ]
            },
            "id 145, removed"
          ],
          commit: [
            {
              _: "id 227, removed",
              build: [
                {
                  _: "id 146, removed",
                  job: [
                    "id 147, removed"
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
                    "id 49, removed"
                  ]
                },
                "id 148, removed"
              ],
              job: [
                {
                  _: "id 149, removed",
                  log: [
                    "id 51, removed",
                    "id 52, removed"
                  ],
                  annotation: [
                    "id 51, removed",
                    "id 52, removed"
                  ],
                  queueable_job: [
                    "id 51, removed",
                    "id 52, removed"
                  ]
                },
                "id 150, removed"
              ],
              request: [
                {
                  _: "id 31, removed",
                  abuse: [
                    "id 27, removed",
                    "id 28, removed"
                  ],
                  message: [
                    "id 27, removed",
                    "id 28, removed"
                  ],
                  job: [
                    {
                      _: "id 154, removed",
                      log: [
                        "id 53, removed",
                        "id 54, removed"
                      ],
                      annotation: [
                        "id 53, removed",
                        "id 54, removed"
                      ],
                      queueable_job: [
                        "id 53, removed",
                        "id 54, removed"
                      ]
                    },
                    "id 155, removed"
                  ],
                  build: [
                    {
                      _: "id 151, removed",
                      job: [
                        "id 152, removed"
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
                        "id 50, removed"
                      ]
                    },
                    "id 153, removed"
                  ]
                },
                "id 32, removed"
              ]
            },
            "id 228, removed"
          ],
          request: [
            {
              _: "id 33, removed",
              abuse: [
                "id 29, removed",
                "id 30, removed"
              ],
              message: [
                "id 29, removed",
                "id 30, removed"
              ],
              job: [
                {
                  _: "id 159, removed",
                  log: [
                    "id 55, removed",
                    "id 56, removed"
                  ],
                  annotation: [
                    "id 55, removed",
                    "id 56, removed"
                  ],
                  queueable_job: [
                    "id 55, removed",
                    "id 56, removed"
                  ]
                },
                "id 160, removed"
              ],
              build: [
                {
                  _: "id 156, removed",
                  job: [
                    "id 157, removed"
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
                    "id 51, removed"
                  ]
                },
                "id 158, removed"
              ]
            },
            "id 34, removed"
          ]
        },
        "id 38, removed"
      ]
    }
  end
end