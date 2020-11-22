def get_best_match(myCV):
    import numpy as np
    import pandas as pd

    gds = pd.read_json('./gd.json',
                       orient='records')

    def Jaccard(x, y):
        """returns the jaccard similarity between two lists """
        intersection_cardinality = len(set.intersection(*[set(x), set(y)]))
        union_cardinality = len(set.union(*[set(x), set(y)]))
        return intersection_cardinality / float(union_cardinality)

    def cal_similarity(cv):
        similarity = []
        for skills in gds.Job_Description:
            similarity.append(Jaccard(cv, skills))

        gds['similarity'] = similarity
        col = ['Job_Title', 'Company_Name', 'Location', 'similarity']
        best = gds.sort_values(by='similarity', ascending=False).head(100).loc[:, col]
        return(best)

    BestMatch = cal_similarity(myCV)

    return BestMatch.to_csv('./BestMatch.csv', encoding='utf-8')

if __name__ == "__main__":
    f = open('test.txt' ,'r')
    lst = f.readlines()
    lst = [i.strip().encode('ascii', 'ignore') for i in lst]
    # f.closed()
    get_best_match(lst)
