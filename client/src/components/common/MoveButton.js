import React, { useState } from 'react';
import styled from 'styled-components';
import MoveModal from './MoveModal';

const Wrapper = styled.div`
    position: relative;
`;

const Button = styled.button`
    margin: 5px 10px;
    padding: 5px 10px;
`;

const MoveButton = () => {
    const [isModalDisplay, setIsModalDisplay] = useState(false);

    return (
        <Wrapper>
            <Button onClick={() => setIsModalDisplay(true)}>카드 이동</Button>
            {isModalDisplay ? <MoveModal onClose={() => setIsModalDisplay(false)} /> : null}
        </Wrapper>
    );
};

export default MoveButton;
