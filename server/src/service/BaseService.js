import { getCustomRepository, getRepository } from 'typeorm';
import { CustomBoardRepository } from '../dao/CustomBoardRepository';
import { CustomCardRepository } from '../dao/CustomCardRepository';
import { Activity } from '../model/Activity';
import { Board } from '../model/Board';
import { Card } from '../model/Card';
import { Comment } from '../model/Comment';
import { Invitation } from '../model/Invitation';
import { List } from '../model/List';
import { User } from '../model/User';

export class BaseService {
    constructor() {
        this.activityRepository = getRepository(Activity);
        this.boardRepository = getRepository(Board);
        this.cardRepository = getRepository(Card);
        this.commentRepository = getRepository(Comment);
        this.invitationRepository = getRepository(Invitation);
        this.listRepository = getRepository(List);
        this.userRepository = getRepository(User);
        this.customBoardRepository = getCustomRepository(CustomBoardRepository);
        this.customCardRepository = getCustomRepository(CustomCardRepository);
    }
}