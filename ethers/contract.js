require("dotenv").config();
const ethers = require("ethers");

var privateKey = process.env.MYKEY;
const provider_sepolia = new ethers.InfuraProvider((network = "sepolia"));
const signer = new ethers.Wallet(privateKey, provider_sepolia);
console.log(signer);

const abi = [
  {
    anonymous: false,
    inputs: [
      { indexed: false, internalType: "string", name: "add", type: "string" },
      {
        indexed: false,
        internalType: "uint256",
        name: "result",
        type: "uint256",
      },
    ],
    name: "ADD",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      { indexed: false, internalType: "string", name: "div", type: "string" },
      {
        indexed: false,
        internalType: "uint256",
        name: "result",
        type: "uint256",
      },
    ],
    name: "DIV",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      { indexed: false, internalType: "string", name: "mul", type: "string" },
      {
        indexed: false,
        internalType: "uint256",
        name: "result",
        type: "uint256",
      },
    ],
    name: "MUL",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      { indexed: false, internalType: "string", name: "sub", type: "string" },
      {
        indexed: false,
        internalType: "uint256",
        name: "result",
        type: "uint256",
      },
    ],
    name: "SUB",
    type: "event",
  },
  {
    inputs: [
      { internalType: "uint256", name: "_a", type: "uint256" },
      { internalType: "uint256", name: "_b", type: "uint256" },
    ],
    name: "add",
    outputs: [{ internalType: "uint256", name: "_c", type: "uint256" }],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      { internalType: "uint256", name: "_a", type: "uint256" },
      { internalType: "uint256", name: "_b", type: "uint256" },
    ],
    name: "div",
    outputs: [{ internalType: "uint256", name: "_c", type: "uint256" }],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      { internalType: "uint256", name: "_a", type: "uint256" },
      { internalType: "uint256", name: "_b", type: "uint256" },
    ],
    name: "mul",
    outputs: [{ internalType: "uint256", name: "_c", type: "uint256" }],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      { internalType: "uint256", name: "_a", type: "uint256" },
      { internalType: "uint256", name: "_b", type: "uint256" },
    ],
    name: "sub",
    outputs: [{ internalType: "uint256", name: "_c", type: "uint256" }],
    stateMutability: "nonpayable",
    type: "function",
  },
];
const c_addr = "0xb82aa324Df0F30e8F76BABa7c36EFE75bf08043D";
const contract = new ethers.Contract(c_addr, abi, signer);
console.log(contract.interface.fragments);

async function main() {
  await contract.add(100, 3);
}

main();
