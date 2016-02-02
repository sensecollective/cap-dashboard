# fs     = require "fs"
topics_dict  = require "../../public/assets/topics_dictionary"
topics       = require "../../public/assets/topic_models_small"
topic_totals = require "../../public/assets/data-totals-per-year"


exports.findByTopic = (req, res) ->
  try
    topic      = req.params.topic
    topic_num  = "#{topics_dict.list[topic]}"
    topic_data = topics.clusters[topic_num]
    res.status(200).send {keywords: topic_data.cluster_words, data: topic_data.data}
  catch e
    res.status(500).send e

exports.findByTopics = (req, res) ->
  t = JSON.parse req.query.topics
  data = {}
  try
    for topic in t
      if topic != "Totals"

        topic_num = "#{topics_dict.list[topic]}"
        topic_data = topics.clusters[topic_num]
        data[topic] = topic_data.data
      else
        data['Total Count'] = topic_totals
    res.status(200).send data
  catch e
    res.status(500).send e

exports.listTopics = (req, res) ->
  try
    list = Object.keys topics_dict.list
    data = {}
    for t in list
      num = topics_dict.list[t]
      data[t] = topics.clusters[num].data.total

    res.status(200).json data
  catch e
    res.status(500).send e

exports.getTotals = (req, res) ->
  try
    totals = topic_totals
    res.status(200).send totals
  catch e
    res.status(500).send e
