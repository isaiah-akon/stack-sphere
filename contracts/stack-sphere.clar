;; Title: 
;; StackSphere: Bitcoin-Native Governance & Analytics Ecosystem

;; Summary
;; StackSphere is an innovative Bitcoin Layer 2 protocol built on Stacks that revolutionizes 
;; decentralized governance through intelligent staking mechanisms and data-driven decision making.
;; Participants lock STX tokens to earn governance rights, access premium analytics, and shape 
;; the future of Bitcoin's decentralized finance ecosystem.

;; Description
;; StackSphere transforms traditional governance by creating a merit-based ecosystem where 
;; Bitcoin believers can actively participate in protocol evolution. Built exclusively on 
;; Bitcoin's security model through Stacks Layer 2, the platform offers:
;;
;; - Multi-tier STX staking with exponential reward scaling
;; - Sophisticated governance framework with proposal lifecycle automation  
;; - SPHERE utility tokens enabling advanced platform features
;; - Dynamic reward distribution aligned with long-term Bitcoin adoption
;; - Enterprise-grade security with emergency protocols and admin safeguards
;;
;; Targeting Bitcoin maximalists, DeFi protocols, and institutional stakeholders, StackSphere 
;; establishes a self-sustaining economy where network participation directly correlates with 
;; governance influence. The protocol implements advanced cryptoeconomic incentives with 
;; time-weighted voting power and anti-manipulation mechanisms to ensure genuine community 
;; governance while maintaining Bitcoin's core principles of decentralization and security.

;; TOKEN DEFINITIONS

(define-fungible-token ANALYTICS-TOKEN u0)

;; CONSTANTS & ERROR CODES

(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-NOT-AUTHORIZED (err u1000))
(define-constant ERR-INVALID-PROTOCOL (err u1001))
(define-constant ERR-INVALID-AMOUNT (err u1002))
(define-constant ERR-INSUFFICIENT-STX (err u1003))
(define-constant ERR-COOLDOWN-ACTIVE (err u1004))
(define-constant ERR-NO-STAKE (err u1005))
(define-constant ERR-BELOW-MINIMUM (err u1006))
(define-constant ERR-PAUSED (err u1007))

;; DATA VARIABLES

(define-data-var contract-paused bool false)
(define-data-var emergency-mode bool false)
(define-data-var stx-pool uint u0)
(define-data-var base-reward-rate uint u500)        ;; 5% base rate (100 = 1%)
(define-data-var bonus-rate uint u100)              ;; 1% bonus for longer staking
(define-data-var minimum-stake uint u1000000)       ;; Minimum stake amount
(define-data-var cooldown-period uint u1440)        ;; 24 hour cooldown in blocks
(define-data-var proposal-count uint u0)

;; DATA MAPS

(define-map Proposals
    { proposal-id: uint }
    {
        creator: principal,
        description: (string-utf8 256),
        start-block: uint,
        end-block: uint,
        executed: bool,
        votes-for: uint,
        votes-against: uint,
        minimum-votes: uint
    }
)

(define-map UserPositions
    principal
    {
        total-collateral: uint,
        total-debt: uint,
        health-factor: uint,
        last-updated: uint,
        stx-staked: uint,
        analytics-tokens: uint,
        voting-power: uint,
        tier-level: uint,
        rewards-multiplier: uint
    }
)

(define-map StakingPositions
    principal
    {
        amount: uint,
        start-block: uint,
        last-claim: uint,
        lock-period: uint,
        cooldown-start: (optional uint),
        accumulated-rewards: uint
    }
)