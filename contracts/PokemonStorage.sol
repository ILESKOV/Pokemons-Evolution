//SPDX-License-Identifier: Unlicense
pragma solidity 0.8.15;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/structs/BitMaps.sol";

/**
 * @title PokemonStorage contract.
 * NOTE: The contract contains all possible evolution data.
 * @dev Contract use Bitmaps from openzeppelin to save on Gas
 */
contract PokemonStorage is ERC1155, Ownable {
    using BitMaps for BitMaps.BitMap;
    BitMaps.BitMap private _latestInEvolution;
    mapping(uint256 => uint256) private _thunderEvolutions;
    mapping(uint256 => uint256) private _moonEvolutions;
    mapping(uint256 => uint256) private _fireEvolutions;
    mapping(uint256 => uint256) private _leafEvolutions;
    mapping(uint256 => uint256) private _sunEvolutions;
    mapping(uint256 => uint256) private _waterEvolutions;
    mapping(uint256 => uint256) private _blackAuguriteEvolutions;
    mapping(uint256 => uint256) private _shinyEvolutions;
    mapping(uint256 => uint256) private _duskEvolutions;
    mapping(uint256 => uint256) private _razorClawEvolutions;
    mapping(uint256 => uint256) private _peatBlockEvolutions;
    mapping(uint256 => uint256) private _tartAppleEvolutions;
    mapping(uint256 => uint256) private _crackedPotEvolutions;
    mapping(uint256 => uint256) private _ovalEvolutions;

    /**
     * @dev Returns bool about availability of evolution.
     */
    function isEvolveNotAvailable(uint256 pokemonNumber) public view returns (bool) {
        return _latestInEvolution.get(pokemonNumber);
    }

    /**
     * @dev Returns data about the possibility of evolution with a thunder stone.
     */
    function isThunderEvolveAvailable(uint256 pokemonNumber) public view returns (uint256) {
        return _thunderEvolutions[pokemonNumber];
    }

    /**
     * @dev Returns data about the possibility of evolution with a moon stone.
     */
    function isMoonEvolveAvailable(uint256 pokemonNumber) public view returns (uint256) {
        return _moonEvolutions[pokemonNumber];
    }

    /**
     * @dev Returns data about the possibility of evolution with a fire stone.
     */
    function isFireEvolveAvailable(uint256 pokemonNumber) public view returns (uint256) {
        return _fireEvolutions[pokemonNumber];
    }

    /**
     * @dev Returns data about the possibility of evolution with a leaf stone.
     */
    function isLeafEvolveAvailable(uint256 pokemonNumber) public view returns (uint256) {
        return _leafEvolutions[pokemonNumber];
    }

    /**
     * @dev Returns data about the possibility of evolution with a sun stone.
     */
    function isSunEvolveAvailable(uint256 pokemonNumber) public view returns (uint256) {
        return _sunEvolutions[pokemonNumber];
    }

    /**
     * @dev Returns data about the possibility of evolution with a water stone.
     */
    function isWaterEvolveAvailable(uint256 pokemonNumber) public view returns (uint256) {
        return _waterEvolutions[pokemonNumber];
    }

    /**
     * @dev Returns data about the possibility of evolution with a black augurite.
     */
    function isBlackAuguriteEvolveAvailable(uint256 pokemonNumber) public view returns (uint256) {
        return _blackAuguriteEvolutions[pokemonNumber];
    }

    /**
     * @dev Returns data about the possibility of evolution with a shiny stone.
     */
    function isShinyEvolveAvailable(uint256 pokemonNumber) public view returns (uint256) {
        return _shinyEvolutions[pokemonNumber];
    }

    /**
     * @dev Returns data about the possibility of evolution with a dusk stone.
     */
    function isDuskEvolveAvailable(uint256 pokemonNumber) public view returns (uint256) {
        return _duskEvolutions[pokemonNumber];
    }

    /**
     * @dev Returns data about the possibility of evolution with a razor claw.
     */
    function isRazorClawEvolveAvailable(uint256 pokemonNumber) public view returns (uint256) {
        return _razorClawEvolutions[pokemonNumber];
    }

    /**
     * @dev Returns data about the possibility of evolution with a peat block.
     */
    function isPeatBlockEvolveAvailable(uint256 pokemonNumber) public view returns (uint256) {
        return _peatBlockEvolutions[pokemonNumber];
    }

    /**
     * @dev Returns data about the possibility of evolution with a tart apple.
     */
    function isTartAppleEvolveAvailable(uint256 pokemonNumber) public view returns (uint256) {
        return _tartAppleEvolutions[pokemonNumber];
    }

    /**
     * @dev Returns data about the possibility of evolution with a cracked pot.
     */
    function isCrackedPotEvolveAvailable(uint256 pokemonNumber) public view returns (uint256) {
        return _crackedPotEvolutions[pokemonNumber];
    }

    /**
     * @dev Returns data about the possibility of evolution with a oval stone
     */
    function isOvalEvolveAvailable(uint256 pokemonNumber) public view returns (uint256) {
        return _ovalEvolutions[pokemonNumber];
    }

    /**
     * @dev Returns uri of each token.
     */
    function uri(uint256 tokenId) public pure override returns (string memory) {
        return (
            string(
                abi.encodePacked(
                    "ipfs://bafybeidhzhc5wjpdvqjldvl5pkbq4lxf2udwkltfx5qzo6gn327xpidpue/",
                    Strings.toString(tokenId)
                )
            )
        );
    }

    /**
     * @dev This is a function to check if evolution is available, and if so, which one.
     * Function return Id of stone or data saying that `level` evolution is available or data saying
     * that this Pokémon cannot be evolved.
     * @param pokemonNumber_ pokemon Id to get evolution data.
     */
    function checkAvailableEvolve(uint256 pokemonNumber_) public view returns (uint256, uint256) {
        if (true == isEvolveNotAvailable(pokemonNumber_)) {
            return (15, 0);
        } else if (isThunderEvolveAvailable(pokemonNumber_) != 0) {
            return (0, isThunderEvolveAvailable(pokemonNumber_));
        } else if (isMoonEvolveAvailable(pokemonNumber_) != 0) {
            return (1, isMoonEvolveAvailable(pokemonNumber_));
        } else if (isFireEvolveAvailable(pokemonNumber_) != 0) {
            return (2, isFireEvolveAvailable(pokemonNumber_));
        } else if (isLeafEvolveAvailable(pokemonNumber_) != 0) {
            return (3, isLeafEvolveAvailable(pokemonNumber_));
        } else if (isSunEvolveAvailable(pokemonNumber_) != 0) {
            return (4, isSunEvolveAvailable(pokemonNumber_));
        } else if (isWaterEvolveAvailable(pokemonNumber_) != 0) {
            return (5, isWaterEvolveAvailable(pokemonNumber_));
        } else if (isBlackAuguriteEvolveAvailable(pokemonNumber_) != 0) {
            return (6, isBlackAuguriteEvolveAvailable(pokemonNumber_));
        } else if (isShinyEvolveAvailable(pokemonNumber_) != 0) {
            return (7, isShinyEvolveAvailable(pokemonNumber_));
        } else if (isDuskEvolveAvailable(pokemonNumber_) != 0) {
            return (8, isDuskEvolveAvailable(pokemonNumber_));
        } else if (isRazorClawEvolveAvailable(pokemonNumber_) != 0) {
            return (9, isRazorClawEvolveAvailable(pokemonNumber_));
        } else if (isPeatBlockEvolveAvailable(pokemonNumber_) != 0) {
            return (10, isPeatBlockEvolveAvailable(pokemonNumber_));
        } else if (isTartAppleEvolveAvailable(pokemonNumber_) != 0) {
            return (11, isTartAppleEvolveAvailable(pokemonNumber_));
        } else if (isCrackedPotEvolveAvailable(pokemonNumber_) != 0) {
            return (12, isCrackedPotEvolveAvailable(pokemonNumber_));
        } else if (isOvalEvolveAvailable(pokemonNumber_) != 0) {
            return (13, isOvalEvolveAvailable(pokemonNumber_));
        } else return (14, 16);
    }

    /**
     * @dev Stores data on all `stone` type evolving opportunities and all latest Pokémons in
     * the chain of evolution.
     */
    constructor() ERC1155("ipfs://bafybeidhzhc5wjpdvqjldvl5pkbq4lxf2udwkltfx5qzo6gn327xpidpue/") {
        _latestInEvolution.set(3);
        _latestInEvolution.set(6);
        _latestInEvolution.set(9);
        _latestInEvolution.set(12);
        _latestInEvolution.set(15);
        _latestInEvolution.set(18);
        _latestInEvolution.set(20);
        _latestInEvolution.set(22);
        _latestInEvolution.set(24);
        _latestInEvolution.set(26);
        _latestInEvolution.set(28);
        _latestInEvolution.set(31);
        _latestInEvolution.set(34);
        _latestInEvolution.set(36);
        _latestInEvolution.set(38);
        _latestInEvolution.set(40);
        _latestInEvolution.set(42);
        _latestInEvolution.set(45);
        _latestInEvolution.set(47);
        _latestInEvolution.set(49);
        _latestInEvolution.set(51);
        _latestInEvolution.set(53);
        _latestInEvolution.set(55);
        _latestInEvolution.set(57);
        _latestInEvolution.set(59);
        _latestInEvolution.set(62);
        _latestInEvolution.set(65);
        _latestInEvolution.set(68);
        _latestInEvolution.set(71);
        _latestInEvolution.set(73);
        _latestInEvolution.set(76);
        _latestInEvolution.set(78);
        _latestInEvolution.set(80);
        _latestInEvolution.set(82);
        _latestInEvolution.set(83);
        _latestInEvolution.set(85);
        _latestInEvolution.set(87);
        _latestInEvolution.set(89);
        _latestInEvolution.set(91);
        _latestInEvolution.set(94);
        _latestInEvolution.set(95);
        _latestInEvolution.set(97);
        _latestInEvolution.set(99);

        _latestInEvolution.set(101);
        _latestInEvolution.set(103);
        _latestInEvolution.set(105);
        _latestInEvolution.set(106);
        _latestInEvolution.set(107);
        _latestInEvolution.set(101);
        _latestInEvolution.set(103);
        _latestInEvolution.set(105);
        _latestInEvolution.set(106);
        _latestInEvolution.set(107);
        _latestInEvolution.set(108);
        _latestInEvolution.set(110);
        _latestInEvolution.set(112);
        _latestInEvolution.set(113);
        _latestInEvolution.set(114);
        _latestInEvolution.set(117);
        _latestInEvolution.set(119);
        _latestInEvolution.set(121);
        _latestInEvolution.set(122);
        _latestInEvolution.set(124);
        _latestInEvolution.set(125);
        _latestInEvolution.set(126);
        _latestInEvolution.set(127);
        _latestInEvolution.set(128);
        _latestInEvolution.set(130);
        _latestInEvolution.set(131);
        _latestInEvolution.set(132);
        _latestInEvolution.set(134);
        _latestInEvolution.set(135);
        _latestInEvolution.set(136);
        _latestInEvolution.set(137);
        _latestInEvolution.set(139);
        _latestInEvolution.set(141);
        _latestInEvolution.set(142);
        _latestInEvolution.set(143);
        _latestInEvolution.set(145);
        _latestInEvolution.set(146);
        _latestInEvolution.set(149);
        _latestInEvolution.set(150);
        _latestInEvolution.set(151);
        _latestInEvolution.set(154);
        _latestInEvolution.set(157);
        _latestInEvolution.set(160);
        _latestInEvolution.set(162);
        _latestInEvolution.set(164);
        _latestInEvolution.set(166);
        _latestInEvolution.set(168);
        _latestInEvolution.set(169);
        _latestInEvolution.set(171);
        _latestInEvolution.set(172);
        _latestInEvolution.set(173);
        _latestInEvolution.set(174);
        _latestInEvolution.set(178);
        _latestInEvolution.set(181);
        _latestInEvolution.set(182);
        _latestInEvolution.set(184);
        _latestInEvolution.set(185);
        _latestInEvolution.set(186);
        _latestInEvolution.set(189);
        _latestInEvolution.set(190);
        _latestInEvolution.set(192);
        _latestInEvolution.set(193);
        _latestInEvolution.set(195);
        _latestInEvolution.set(196);
        _latestInEvolution.set(197);
        _latestInEvolution.set(199);

        _latestInEvolution.set(201);
        _latestInEvolution.set(202);
        _latestInEvolution.set(203);
        _latestInEvolution.set(205);
        _latestInEvolution.set(206);
        _latestInEvolution.set(207);
        _latestInEvolution.set(208);
        _latestInEvolution.set(210);
        _latestInEvolution.set(211);
        _latestInEvolution.set(212);
        _latestInEvolution.set(213);
        _latestInEvolution.set(214);
        _latestInEvolution.set(219);
        _latestInEvolution.set(221);
        _latestInEvolution.set(222);
        _latestInEvolution.set(224);
        _latestInEvolution.set(225);
        _latestInEvolution.set(226);
        _latestInEvolution.set(227);
        _latestInEvolution.set(229);
        _latestInEvolution.set(230);
        _latestInEvolution.set(232);
        _latestInEvolution.set(233);
        _latestInEvolution.set(234);
        _latestInEvolution.set(235);
        _latestInEvolution.set(236);
        _latestInEvolution.set(237);
        _latestInEvolution.set(238);
        _latestInEvolution.set(239);
        _latestInEvolution.set(240);
        _latestInEvolution.set(241);
        _latestInEvolution.set(242);
        _latestInEvolution.set(243);
        _latestInEvolution.set(244);
        _latestInEvolution.set(245);
        _latestInEvolution.set(248);
        _latestInEvolution.set(249);
        _latestInEvolution.set(250);
        _latestInEvolution.set(251);
        _latestInEvolution.set(254);
        _latestInEvolution.set(257);
        _latestInEvolution.set(260);
        _latestInEvolution.set(262);
        _latestInEvolution.set(264);
        _latestInEvolution.set(269);
        _latestInEvolution.set(272);
        _latestInEvolution.set(275);
        _latestInEvolution.set(277);
        _latestInEvolution.set(279);
        _latestInEvolution.set(282);
        _latestInEvolution.set(284);
        _latestInEvolution.set(286);
        _latestInEvolution.set(289);
        _latestInEvolution.set(292);
        _latestInEvolution.set(295);
        _latestInEvolution.set(297);
        _latestInEvolution.set(298);
        _latestInEvolution.set(299);

        _latestInEvolution.set(301);
        _latestInEvolution.set(302);
        _latestInEvolution.set(303);
        _latestInEvolution.set(306);
        _latestInEvolution.set(308);
        _latestInEvolution.set(310);
        _latestInEvolution.set(311);
        _latestInEvolution.set(312);
        _latestInEvolution.set(313);
        _latestInEvolution.set(314);
        _latestInEvolution.set(317);
        _latestInEvolution.set(319);
        _latestInEvolution.set(321);
        _latestInEvolution.set(323);
        _latestInEvolution.set(324);
        _latestInEvolution.set(326);
        _latestInEvolution.set(327);
        _latestInEvolution.set(330);
        _latestInEvolution.set(332);
        _latestInEvolution.set(334);
        _latestInEvolution.set(335);
        _latestInEvolution.set(336);
        _latestInEvolution.set(337);
        _latestInEvolution.set(338);
        _latestInEvolution.set(340);
        _latestInEvolution.set(342);
        _latestInEvolution.set(344);
        _latestInEvolution.set(346);
        _latestInEvolution.set(348);
        _latestInEvolution.set(350);
        _latestInEvolution.set(351);
        _latestInEvolution.set(352);
        _latestInEvolution.set(354);
        _latestInEvolution.set(356);
        _latestInEvolution.set(357);
        _latestInEvolution.set(358);
        _latestInEvolution.set(359);
        _latestInEvolution.set(360);
        _latestInEvolution.set(362);
        _latestInEvolution.set(365);
        _latestInEvolution.set(368);
        _latestInEvolution.set(369);
        _latestInEvolution.set(370);
        _latestInEvolution.set(373);
        _latestInEvolution.set(376);
        _latestInEvolution.set(377);
        _latestInEvolution.set(378);
        _latestInEvolution.set(379);
        _latestInEvolution.set(380);
        _latestInEvolution.set(381);
        _latestInEvolution.set(382);
        _latestInEvolution.set(383);
        _latestInEvolution.set(384);
        _latestInEvolution.set(385);
        _latestInEvolution.set(386);
        _latestInEvolution.set(389);
        _latestInEvolution.set(392);
        _latestInEvolution.set(395);
        _latestInEvolution.set(398);

        _latestInEvolution.set(400);
        _latestInEvolution.set(402);
        _latestInEvolution.set(407);
        _latestInEvolution.set(405);
        _latestInEvolution.set(409);
        _latestInEvolution.set(411);
        _latestInEvolution.set(414);
        _latestInEvolution.set(416);
        _latestInEvolution.set(419);
        _latestInEvolution.set(421);
        _latestInEvolution.set(423);
        _latestInEvolution.set(424);
        _latestInEvolution.set(426);
        _latestInEvolution.set(428);
        _latestInEvolution.set(429);
        _latestInEvolution.set(430);
        _latestInEvolution.set(432);
        _latestInEvolution.set(433);
        _latestInEvolution.set(435);
        _latestInEvolution.set(437);
        _latestInEvolution.set(438);
        _latestInEvolution.set(439);
        _latestInEvolution.set(441);
        _latestInEvolution.set(442);
        _latestInEvolution.set(445);
        _latestInEvolution.set(446);
        _latestInEvolution.set(448);
        _latestInEvolution.set(450);
        _latestInEvolution.set(452);
        _latestInEvolution.set(454);
        _latestInEvolution.set(455);
        _latestInEvolution.set(457);
        _latestInEvolution.set(458);
        _latestInEvolution.set(460);
        _latestInEvolution.set(461);
        _latestInEvolution.set(462);
        _latestInEvolution.set(463);
        _latestInEvolution.set(464);
        _latestInEvolution.set(465);
        _latestInEvolution.set(466);
        _latestInEvolution.set(467);
        _latestInEvolution.set(468);
        _latestInEvolution.set(469);
        _latestInEvolution.set(470);
        _latestInEvolution.set(471);
        _latestInEvolution.set(472);
        _latestInEvolution.set(473);
        _latestInEvolution.set(474);
        _latestInEvolution.set(475);
        _latestInEvolution.set(476);
        _latestInEvolution.set(477);
        _latestInEvolution.set(478);
        _latestInEvolution.set(479);
        _latestInEvolution.set(480);
        _latestInEvolution.set(481);
        _latestInEvolution.set(482);
        _latestInEvolution.set(483);
        _latestInEvolution.set(484);
        _latestInEvolution.set(485);
        _latestInEvolution.set(486);
        _latestInEvolution.set(487);
        _latestInEvolution.set(488);
        _latestInEvolution.set(489);
        _latestInEvolution.set(490);
        _latestInEvolution.set(491);
        _latestInEvolution.set(492);
        _latestInEvolution.set(493);
        _latestInEvolution.set(494);
        _latestInEvolution.set(497);

        _latestInEvolution.set(500);
        _latestInEvolution.set(503);
        _latestInEvolution.set(505);
        _latestInEvolution.set(508);
        _latestInEvolution.set(510);
        _latestInEvolution.set(512);
        _latestInEvolution.set(514);
        _latestInEvolution.set(516);
        _latestInEvolution.set(518);
        _latestInEvolution.set(521);
        _latestInEvolution.set(523);
        _latestInEvolution.set(526);
        _latestInEvolution.set(528);
        _latestInEvolution.set(530);
        _latestInEvolution.set(531);
        _latestInEvolution.set(534);
        _latestInEvolution.set(537);
        _latestInEvolution.set(538);
        _latestInEvolution.set(539);
        _latestInEvolution.set(542);
        _latestInEvolution.set(545);
        _latestInEvolution.set(547);
        _latestInEvolution.set(549);
        _latestInEvolution.set(550);
        _latestInEvolution.set(553);
        _latestInEvolution.set(555);
        _latestInEvolution.set(556);
        _latestInEvolution.set(558);
        _latestInEvolution.set(560);
        _latestInEvolution.set(561);
        _latestInEvolution.set(563);
        _latestInEvolution.set(565);
        _latestInEvolution.set(567);
        _latestInEvolution.set(569);
        _latestInEvolution.set(571);
        _latestInEvolution.set(573);
        _latestInEvolution.set(576);
        _latestInEvolution.set(579);
        _latestInEvolution.set(581);
        _latestInEvolution.set(584);
        _latestInEvolution.set(586);
        _latestInEvolution.set(587);
        _latestInEvolution.set(589);
        _latestInEvolution.set(591);
        _latestInEvolution.set(593);
        _latestInEvolution.set(594);
        _latestInEvolution.set(596);
        _latestInEvolution.set(598);

        _latestInEvolution.set(601);
        _latestInEvolution.set(604);
        _latestInEvolution.set(606);
        _latestInEvolution.set(609);
        _latestInEvolution.set(612);
        _latestInEvolution.set(614);
        _latestInEvolution.set(615);
        _latestInEvolution.set(617);
        _latestInEvolution.set(618);
        _latestInEvolution.set(620);
        _latestInEvolution.set(621);
        _latestInEvolution.set(623);
        _latestInEvolution.set(625);
        _latestInEvolution.set(626);
        _latestInEvolution.set(628);
        _latestInEvolution.set(630);
        _latestInEvolution.set(631);
        _latestInEvolution.set(632);
        _latestInEvolution.set(635);
        _latestInEvolution.set(637);
        _latestInEvolution.set(638);
        _latestInEvolution.set(639);
        _latestInEvolution.set(640);
        _latestInEvolution.set(641);
        _latestInEvolution.set(642);
        _latestInEvolution.set(643);
        _latestInEvolution.set(644);
        _latestInEvolution.set(645);
        _latestInEvolution.set(646);
        _latestInEvolution.set(647);
        _latestInEvolution.set(648);
        _latestInEvolution.set(649);
        _latestInEvolution.set(652);
        _latestInEvolution.set(655);
        _latestInEvolution.set(658);
        _latestInEvolution.set(660);
        _latestInEvolution.set(663);
        _latestInEvolution.set(666);
        _latestInEvolution.set(668);
        _latestInEvolution.set(671);
        _latestInEvolution.set(673);
        _latestInEvolution.set(675);
        _latestInEvolution.set(676);
        _latestInEvolution.set(678);
        _latestInEvolution.set(681);
        _latestInEvolution.set(683);
        _latestInEvolution.set(685);
        _latestInEvolution.set(687);
        _latestInEvolution.set(689);
        _latestInEvolution.set(691);
        _latestInEvolution.set(693);
        _latestInEvolution.set(695);
        _latestInEvolution.set(697);
        _latestInEvolution.set(699);

        _latestInEvolution.set(700);
        _latestInEvolution.set(701);
        _latestInEvolution.set(702);
        _latestInEvolution.set(703);
        _latestInEvolution.set(706);
        _latestInEvolution.set(707);
        _latestInEvolution.set(709);
        _latestInEvolution.set(711);
        _latestInEvolution.set(713);
        _latestInEvolution.set(715);
        _latestInEvolution.set(716);
        _latestInEvolution.set(717);
        _latestInEvolution.set(718);
        _latestInEvolution.set(719);
        _latestInEvolution.set(720);
        _latestInEvolution.set(721);
        _latestInEvolution.set(724);
        _latestInEvolution.set(727);
        _latestInEvolution.set(730);
        _latestInEvolution.set(733);
        _latestInEvolution.set(735);
        _latestInEvolution.set(738);
        _latestInEvolution.set(740);
        _latestInEvolution.set(743);
        _latestInEvolution.set(745);
        _latestInEvolution.set(746);
        _latestInEvolution.set(748);
        _latestInEvolution.set(750);
        _latestInEvolution.set(752);
        _latestInEvolution.set(754);
        _latestInEvolution.set(756);
        _latestInEvolution.set(758);
        _latestInEvolution.set(760);
        _latestInEvolution.set(763);
        _latestInEvolution.set(768);
        _latestInEvolution.set(770);
        _latestInEvolution.set(771);
        _latestInEvolution.set(773);
        _latestInEvolution.set(774);
        _latestInEvolution.set(775);
        _latestInEvolution.set(776);
        _latestInEvolution.set(777);
        _latestInEvolution.set(778);
        _latestInEvolution.set(779);
        _latestInEvolution.set(780);
        _latestInEvolution.set(781);
        _latestInEvolution.set(784);
        _latestInEvolution.set(785);
        _latestInEvolution.set(786);
        _latestInEvolution.set(787);
        _latestInEvolution.set(788);
        _latestInEvolution.set(791);
        _latestInEvolution.set(792);
        _latestInEvolution.set(793);
        _latestInEvolution.set(794);
        _latestInEvolution.set(795);
        _latestInEvolution.set(796);
        _latestInEvolution.set(797);
        _latestInEvolution.set(798);
        _latestInEvolution.set(799);

        _latestInEvolution.set(800);
        _latestInEvolution.set(801);
        _latestInEvolution.set(802);
        _latestInEvolution.set(804);
        _latestInEvolution.set(805);
        _latestInEvolution.set(806);
        _latestInEvolution.set(807);
        _latestInEvolution.set(809);
        _latestInEvolution.set(812);
        _latestInEvolution.set(815);
        _latestInEvolution.set(818);
        _latestInEvolution.set(820);
        _latestInEvolution.set(823);
        _latestInEvolution.set(826);
        _latestInEvolution.set(828);
        _latestInEvolution.set(830);
        _latestInEvolution.set(832);
        _latestInEvolution.set(834);
        _latestInEvolution.set(836);
        _latestInEvolution.set(839);
        _latestInEvolution.set(842);
        _latestInEvolution.set(844);
        _latestInEvolution.set(845);
        _latestInEvolution.set(847);
        _latestInEvolution.set(849);
        _latestInEvolution.set(851);
        _latestInEvolution.set(853);
        _latestInEvolution.set(855);
        _latestInEvolution.set(858);
        _latestInEvolution.set(861);
        _latestInEvolution.set(862);
        _latestInEvolution.set(863);
        _latestInEvolution.set(864);
        _latestInEvolution.set(865);
        _latestInEvolution.set(866);
        _latestInEvolution.set(867);
        _latestInEvolution.set(868);
        _latestInEvolution.set(869);
        _latestInEvolution.set(870);
        _latestInEvolution.set(871);
        _latestInEvolution.set(873);
        _latestInEvolution.set(874);
        _latestInEvolution.set(875);
        _latestInEvolution.set(876);
        _latestInEvolution.set(877);
        _latestInEvolution.set(879);
        _latestInEvolution.set(880);
        _latestInEvolution.set(881);
        _latestInEvolution.set(882);
        _latestInEvolution.set(883);
        _latestInEvolution.set(884);
        _latestInEvolution.set(887);
        _latestInEvolution.set(888);
        _latestInEvolution.set(889);
        _latestInEvolution.set(890);
        _latestInEvolution.set(892);
        _latestInEvolution.set(893);
        _latestInEvolution.set(894);
        _latestInEvolution.set(895);
        _latestInEvolution.set(896);
        _latestInEvolution.set(897);
        _latestInEvolution.set(898);
        _latestInEvolution.set(899);
        _latestInEvolution.set(900);
        _latestInEvolution.set(901);
        _latestInEvolution.set(902);
        _latestInEvolution.set(903);
        _latestInEvolution.set(904);
        _latestInEvolution.set(905);

        _thunderEvolutions[25] = 26;
        _thunderEvolutions[133] = 135;
        _thunderEvolutions[603] = 604;
        _moonEvolutions[30] = 31;
        _moonEvolutions[33] = 34;
        _moonEvolutions[35] = 36;
        _moonEvolutions[39] = 40;
        _moonEvolutions[300] = 301;
        _moonEvolutions[517] = 518;
        _fireEvolutions[37] = 38;
        _fireEvolutions[58] = 59;
        _fireEvolutions[513] = 514;
        _fireEvolutions[133] = 136;
        _leafEvolutions[44] = 45;
        _leafEvolutions[70] = 71;
        _leafEvolutions[102] = 103;
        _leafEvolutions[274] = 275;
        _leafEvolutions[511] = 512;
        _leafEvolutions[133] = 470;
        _sunEvolutions[44] = 182;
        _sunEvolutions[191] = 192;
        _sunEvolutions[546] = 547;
        _sunEvolutions[548] = 549;
        _sunEvolutions[694] = 695;
        _waterEvolutions[61] = 62;
        _waterEvolutions[90] = 91;
        _waterEvolutions[120] = 121;
        _waterEvolutions[271] = 272;
        _waterEvolutions[515] = 516;
        _waterEvolutions[133] = 134;
        _blackAuguriteEvolutions[123] = 900;
        _shinyEvolutions[176] = 468;
        _shinyEvolutions[315] = 407;
        _shinyEvolutions[572] = 573;
        _shinyEvolutions[670] = 671;
        _duskEvolutions[198] = 430;
        _duskEvolutions[200] = 429;
        _duskEvolutions[608] = 609;
        _duskEvolutions[680] = 681;
        _razorClawEvolutions[215] = 461;
        _peatBlockEvolutions[217] = 901;
        _tartAppleEvolutions[840] = 841;
        _crackedPotEvolutions[854] = 855;
        _ovalEvolutions[440] = 113;
    }
}
