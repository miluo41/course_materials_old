# Problem Set 4A
# Name: <your name here>
# Collaborators:
# Time Spent: x:xx

def get_permutations(sequence):
    '''
    Enumerate all permutations of a given string

    sequence (string): an arbitrary string to permute. Assume that it is a
    non-empty string.  

    You MUST use recursion for this part. Non-recursive solutions will not be
    accepted.

    Returns: a list of all permutations of sequence

    Example:
    >>> get_permutations('abc')
    ['abc', 'acb', 'bac', 'bca', 'cab', 'cba']

    Note: depending on your implementation, you may return the permutations in
    a different order than what is listed here.
    '''
    def add_one(seq,one):
        add_one_list=[]
        for i in range(len(seq)+1):
            seq2=list(seq)
            seq2.insert(i,one)
            add_one_list.append(''.join(seq2))
        return add_one_list
            
    if len(sequence)==1:
        return list(sequence)
    else:
        perm_list=[]
        for i in get_permutations(sequence[1:]):
            perm_list+=add_one(i,sequence[0])
        return perm_list

if __name__ == '__main__':
#    #EXAMPLE
    example_input = 'abc'
    print('Input:', example_input)
    print('Expected Output:', ['abc', 'acb', 'bac', 'bca', 'cab', 'cba'])
    print('Actual Output:', get_permutations(example_input))
    
    example_input2 = 'ab'
    print('Input:',example_input2)
    print('Expected Output:', ['ab','ba'])
    print('Actural Output:',get_permutations(example_input2))
    
    example_input3 = '123'
    print('Input:',example_input3)
    print('Expected Output:', ['123','132','213','231','312','321'])
    print('Actural Output:',get_permutations(example_input3))
    
    
#    # Put three example test cases here (for your sanity, limit your inputs
#    to be three characters or fewer as you will have n! permutations for a 
#    sequence of length n)


