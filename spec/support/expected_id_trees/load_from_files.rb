class ExpectedIdTrees
  def self.load_from_files
    [
      {
        job: [
          {
            log: [
              100,
              101
            ],
            annotation: [
              100,
              101
            ],
            queueable_job: [
              100,
              101
            ],
            id: 105
          },
          106
        ],
        repository: [
          20,
          21,
          18,
          19
        ],
        tag: [
          1,
          6
        ],
        branch: [
          77,
          82
        ],
        stage: [
          {
            job: [
              101,
              102
            ],
            id: 100
          },
          {
            job: [
              103,
              104
            ],
            id: 101
          }
        ],
        id: 100
      },
      149,
      {
        job: [
          {
            log: [
              156,
              157
            ],
            annotation: [
              156,
              157
            ],
            queueable_job: [
              156,
              157
            ],
            id: 265
          },
          266
        ],
        stage: [
          {
            job: [
              261,
              262
            ],
            id: 132
          },
          {
            job: [
              263,
              264
            ],
            id: 133
          }
        ],
        id: 260
      },
      {
        job: [
          {
            log: [
              160,
              161
            ],
            annotation: [
              160,
              161
            ],
            queueable_job: [
              160,
              161
            ],
            id: 279
          },
          280
        ],
        repository: [
          {
            build: [
              {
                job: [
                  {
                    log: [
                      100,
                      101
                    ],
                    annotation: [
                      100,
                      101
                    ],
                    queueable_job: [
                      100,
                      101
                    ],
                    id: 105
                  },
                  106
                ],
                repository: [
                  20,
                  21,
                  18,
                  19
                ],
                tag: [
                  1,
                  6
                ],
                branch: [
                  77,
                  82
                ],
                stage: [
                  {
                    job: [
                      101,
                      102
                    ],
                    id: 100
                  },
                  {
                    job: [
                      103,
                      104
                    ],
                    id: 101
                  }
                ],
                id: 100
              },
              149,
              {
                job: [
                  {
                    log: [
                      156,
                      157
                    ],
                    annotation: [
                      156,
                      157
                    ],
                    queueable_job: [
                      156,
                      157
                    ],
                    id: 265
                  },
                  266
                ],
                stage: [
                  {
                    job: [
                      261,
                      262
                    ],
                    id: 132
                  },
                  {
                    job: [
                      263,
                      264
                    ],
                    id: 133
                  }
                ],
                id: 260
              },
              {
                job: [
                  {
                    log: [
                      160,
                      161
                    ],
                    annotation: [
                      160,
                      161
                    ],
                    queueable_job: [
                      160,
                      161
                    ],
                    id: 279
                  },
                  280
                ],
                repository: [
                  {
                    build: [
                      100,
                      149,
                      260,
                      274
                    ],
                    branch: [
                      77,
                      82
                    ],
                    id: 1
                  }
                ],
                stage: [
                  {
                    job: [
                      275,
                      276
                    ],
                    id: 136
                  },
                  {
                    job: [
                      277,
                      278
                    ],
                    id: 137
                  }
                ],
                id: 274
              }
            ],
            branch: [
              77,
              82
            ],
            id: 1
          }
        ],
        stage: [
          {
            job: [
              275,
              276
            ],
            id: 136
          },
          {
            job: [
              277,
              278
            ],
            id: 137
          }
        ],
        id: 274
      }
    ]
  end
end