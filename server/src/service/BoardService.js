import { Transactional } from 'typeorm-transactional-cls-hooked';
import { BaseService } from './BaseService';

export class BoardService extends BaseService {
    static instance = null;

    static getInstance() {
        if (BoardService.instance === null) {
            BoardService.instance = new BoardService();
        }

        return BoardService.instance;
    }

    async getMyBoards(id) {
        const boards = await this.boardRepository.find({
            select: ['id', 'title'],
            where: { creator: id },
        });
        return boards;
    }

    async getInvitedBoards(id) {
        const boards = await this.boardRepository
            .createQueryBuilder('board')
            .select('board.id')
            .addSelect('board.title')
            .innerJoin('board.invitations', 'invitation', 'invitation.user_id=:userId', {
                userId: id,
            })
            .getMany();
        return boards;
    }

    @Transactional()
    async getBoardsByUserId(userId) {
        const promises = [this.getMyBoards(userId), this.getInvitedBoards(userId)];
        const [myBoards, invitedBoards] = await Promise.all(promises);

        return { myBoards, invitedBoards };
    }

    @Transactional()
    async getBoardIdsByUserId(userId) {
        const boards = await this.boardRepository
            .createQueryBuilder('board')
            .select('board.id', 'id')
            .leftJoin('board.invitations', 'invitation')
            .where(`board.creator_id=:userId or invitation.user_id=:userId`, { userId })
            .getRawMany();

        const boardIds = boards.map((ele) => ele.id);

        return boardIds;
    }

    @Transactional()
    async createBoard({ userId, title, color }) {
        const board = {
            creator: userId,
            title,
            color,
        };
        const createBoard = this.boardRepository.create(board);
        await this.boardRepository.save(createBoard);
        return createBoard.id;
    }
}