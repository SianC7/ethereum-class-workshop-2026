"use client";

import React, { useEffect, useState } from "react";
import { NFTCard } from "./NFTCard";
import { useAccount } from "wagmi";
import { useScaffoldContract, useScaffoldReadContract } from "~~/hooks/scaffold-eth";
import { notification } from "~~/utils/scaffold-eth";
import { getMetadataFromIPFS } from "~~/utils/simpleNFT/ipfs-fetch";
import { NFTMetaData } from "~~/utils/simpleNFT/nftsMetadata";

export interface Collectible extends Partial<NFTMetaData> {
  id: number;
  uri: string;
  owner: string;
}

export const MyHoldings = () => {
  const { address: connectedAddress } = useAccount();

  const [myAllCollectibles, setMyAllCollectibles] = useState<Collectible[]>([]);
  const [myApprovedCollectibles, setMyApprovedCollectibles] = useState<Collectible[]>([]);

  const [allCollectiblesLoading, setAllCollectiblesLoading] = useState(false);
  const [approvedCollectiblesLoading, setApprovedCollectiblesLoading] = useState(false);

  const { data: yourCollectibleContract } = useScaffoldContract({
    contractName: "YourCollectible",
  });

  const { data: myTotalBalance } = useScaffoldReadContract({
    contractName: "YourCollectible",
    functionName: "balanceOf",
    args: [connectedAddress],
    watch: true,
  });

  const { data: myApprovedBalance } = useScaffoldReadContract({
    contractName: "YourCollectible",
    functionName: "approvedBalanceOf",
    args: [connectedAddress],
    watch: true,
  });

  useEffect(() => {
    const updateMyCollectibles = async (): Promise<void> => {
      if (myTotalBalance === undefined || yourCollectibleContract === undefined || connectedAddress === undefined)
        return;

      setAllCollectiblesLoading(true);
      const collectibleUpdate: Collectible[] = [];
      const totalBalance = parseInt(myTotalBalance.toString());
      for (let tokenIndex = 0; tokenIndex < totalBalance; tokenIndex++) {
        try {
          const tokenId = await yourCollectibleContract.read.tokenOfOwnerByIndex([
            connectedAddress,
            BigInt(tokenIndex),
          ]);

          const tokenURI = await yourCollectibleContract.read.tokenURI([tokenId]);

          const ipfsHash = tokenURI.replace("https://ipfs.io/ipfs/", "");

          const nftMetadata: NFTMetaData = await getMetadataFromIPFS(ipfsHash);

          collectibleUpdate.push({
            id: parseInt(tokenId.toString()),
            uri: tokenURI,
            owner: connectedAddress,
            ...nftMetadata,
          });
        } catch (e) {
          notification.error("Error fetching all collectibles");
          setAllCollectiblesLoading(false);
          console.log(e);
        }
      }
      collectibleUpdate.sort((a, b) => a.id - b.id);
      setMyAllCollectibles(collectibleUpdate);
      setAllCollectiblesLoading(false);
    };

    updateMyCollectibles();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [connectedAddress, myTotalBalance]);

  useEffect(() => {
    const updateMyCollectibles = async (): Promise<void> => {
      if (myApprovedBalance === undefined || yourCollectibleContract === undefined || connectedAddress === undefined)
        return;

      setApprovedCollectiblesLoading(true);
      const collectibleUpdate: Collectible[] = [];
      const totalBalance = parseInt(myApprovedBalance.toString());
      for (let tokenIndex = 0; tokenIndex < totalBalance; tokenIndex++) {
        try {
          const tokenId = await yourCollectibleContract.read.approvedTokenByIndex([
            connectedAddress,
            BigInt(tokenIndex),
          ]);

          // get the token owner
          const tokenOwner = await yourCollectibleContract.read.ownerOf([tokenId]);

          const tokenURI = await yourCollectibleContract.read.tokenURI([tokenId]);

          const ipfsHash = tokenURI.replace("https://ipfs.io/ipfs/", "");

          const nftMetadata: NFTMetaData = await getMetadataFromIPFS(ipfsHash);

          collectibleUpdate.push({
            id: parseInt(tokenId.toString()),
            uri: tokenURI,
            owner: tokenOwner,
            ...nftMetadata,
          });
        } catch (e) {
          notification.error("Error fetching all collectibles");
          setApprovedCollectiblesLoading(false);
          console.log(e);
        }
      }
      collectibleUpdate.sort((a, b) => a.id - b.id);
      setMyApprovedCollectibles(collectibleUpdate);
      setApprovedCollectiblesLoading(false);
    };

    updateMyCollectibles();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [connectedAddress, myApprovedBalance]);

  if (allCollectiblesLoading || approvedCollectiblesLoading)
    return (
      <div className="flex justify-center items-center mt-10">
        <span className="loading loading-spinner loading-lg"></span>
      </div>
    );

  return (
    <div className="flex w-full mt-10">
      {myAllCollectibles.length === 0 ? (
        <div className="flex flex-col items-center">
          <div className="badge badge-soft badge-primary text-lg p-4 text-nowrap">Owned NFTs</div>
        </div>
      ) : (
        <div className="flex flex-col items-center grow">
          <div className="badge badge-soft badge-primary text-lg p-4 text-nowrap">Owned NFTs</div>
          <div className="flex flex-wrap gap-4 my-8 px-5">
            {myAllCollectibles.map(item => (
              <NFTCard nft={item} key={item.id} />
            ))}
          </div>
        </div>
      )}

      <div className="divider divider-horizontal"></div>

      {myApprovedCollectibles.length === 0 ? (
        <div className="flex flex-col items-center">
          <div className="badge badge-soft badge-primary text-lg p-4 text-nowrap">Approved NFTs</div>
        </div>
      ) : (
        <div className="flex flex-col items-center grow">
          <div className="badge badge-soft badge-primary text-lg p-4 text-nowrap">Approved NFTs</div>
          <div className="flex flex-wrap gap-4 my-8 px-5">
            {myApprovedCollectibles.map(item => (
              <NFTCard nft={item} key={item.id} />
            ))}
          </div>
        </div>
      )}
    </div>
  );
};
