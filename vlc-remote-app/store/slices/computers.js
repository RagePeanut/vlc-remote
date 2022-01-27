import { createSlice } from '@reduxjs/toolkit';

const computersSlice = createSlice({
    name: 'computers',
    initialState: [],
    reducers: {
        addComputer: (state, action) => [ ...state, action.payload ],
        editComputer: (state, action) => state.map(computer => computer.id === action.payload.id ? action.payload : computer),
    },
});

export const { addComputer, editComputer } = computersSlice.actions;

export default computersSlice;
