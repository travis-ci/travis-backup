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