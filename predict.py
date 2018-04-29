data = []
for i in range(len(test_features)):
  data.append([])
  for col in COLUMNS[:-1]: # ignore 'income-level' column as it isn't in feature set.
    # convert from numpy integers to standard integers
    data[i].append(int(np.uint64(test_features[col][i]).item()))

# write the test data to a json file
with open('input.json', 'w') as outfile:
  json.dump(data, outfile)