import 'dart:collection';

class LoopingList<E> extends ListBase<E> {
    List<E> _list = List<E>();
    int _index = -1;

    @override
    int get length => _list.length;

    @override
    set length(int length) => _list.length = length;

    @override
    E operator [] (int relativeIndex) {
        return _list[_loop(_index + relativeIndex)];
    }
  
    @override
    void operator []= (int relativeIndex, E value) {
        _list[_loop(_index + relativeIndex)] = value;
    }

    @override
    void add(E value) {
        insert(1, value);
    }

    @override
    void addAll(Iterable<E> all) {
        insertAll(1, all);
    }

    @override
    void insert(int relativeIndex, E value) {
        int insertionIndex = _loop(_index + relativeIndex);
        _list.insert(insertionIndex, value);
        if(_index == -1) _index = 0;
        else if(insertionIndex < _index) _index = insertionIndex;
    }

    @override
    void insertAll(int relativeIndex, Iterable<E> all) {
        int insertionIndex = _loop(_index + relativeIndex);
        _list.insertAll(insertionIndex, all);
        if(_index == -1) _index = 0;
        else if(insertionIndex <= _index) _index = _loop(_index + all.length);
    }

    @override
    void clear() {
        _list.clear();
        _index = -1;
    }

    E move(int relativeIndex) {
        _index = _loop(_index + relativeIndex);
        return _list[_index];
    }

    void setAndMove(int relativeIndex, E value) {
        move(relativeIndex);
        _list[_index] = value;
    }

    // TODO: override all methods that could have an effect on the index

    int _loop(int index) {
        if(length == 0) return 0;
        return index < 0 ? (length + index) % length
                         : index % length;
    }

}