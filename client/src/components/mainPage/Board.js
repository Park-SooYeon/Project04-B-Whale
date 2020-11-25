import React from 'react';
import { Link } from 'react-router-dom';
import styled from 'styled-components';

const BoardTitle = styled.li`
    padding: 8px 0;
    margin-bottom: 2px;
    border: ${(props) => props.theme.border};
    font-size: 18px;
    font-weight: 700;
    text-align: center;
    cursor: pointer;
`;

const Board = ({ id, title }) => {
    return (
        <Link to={`/board/${id}`}>
            <BoardTitle>{title}</BoardTitle>
        </Link>
    );
};

export default Board;
