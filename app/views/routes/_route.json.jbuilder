json.id             path.pluck(:id).join('_')
json.start_date     path.first.start_date
json.end_date       path.last.end_date
json.commute_time   path.last.end_date - path.first.start_date
json.price          (path.last.end_date - path.first.start_date) * 0.001
json.currency       '€'
