<template>
    <el-container class="layout-container-demo">
        <!-- 側欄 -->
        <el-aside>
            <el-scrollbar>
                <el-menu router :default-openeds="[]"> <!-- 預設開啟 -->
                    <el-sub-menu index="1">
                        <template #title>
                            <el-icon>
                                <Tools />
                            </el-icon>作業管理
                        </template>
                        <el-menu-item-group title="生產管理">
                            <el-menu-item index="/ProductionOrderManPage">生產訂單規劃</el-menu-item>
                            <el-menu-item index="/InventoryManPage">庫存管理</el-menu-item>
                        </el-menu-item-group>
                        <el-menu-item-group title="資訊查詢">
                            <el-menu-item index="/MaterialOrderQueryPage">原物料訂單進度查詢</el-menu-item>
                            <el-menu-item index="/PartNoOrderQueryPage">料號訂單進度查詢</el-menu-item>
                        </el-menu-item-group>
                    </el-sub-menu>
                    <el-sub-menu index="2">
                        <template #title>
                            <el-icon>
                                <UserFilled />
                            </el-icon>顧客關係管理
                        </template>
                        <el-menu-item index="/CustomerManPage">顧客資料查詢</el-menu-item>
                    </el-sub-menu>
                </el-menu>
            </el-scrollbar>
        </el-aside>
        <!--頂欄-->
        <el-container>
            <el-header class="header-content">
                <div class="company_name">
                    <el-text>華機企業股份有限公司</el-text>
                </div>
                <div class="toolbar">
                    <el-icon style="margin-right: 8px">
                                <User />
                            </el-icon>
                    <el-dropdown class="container-top-right">
                        <div>
                            <el-text> Admin </el-text>
                            <el-icon style="margin-left: 5px">
                                <ArrowDown />
                            </el-icon>
                        </div>
                        <template #dropdown>
                            <el-dropdown-menu>
                                <el-dropdown-item>Setting</el-dropdown-item>
                                <el-dropdown-item>Log out</el-dropdown-item>
                            </el-dropdown-menu>
                        </template>
                    </el-dropdown>
                </div>
            </el-header>
        </el-container>
    </el-container>
</template>

<script setup>
import { ref } from 'vue'
import { User, ArrowDown} from '@element-plus/icons-vue'

</script>

<style scoped>
.layout-container-demo {
    display: flex;
}

.layout-container-demo .el-header {
    background-color: var(--el-color-primary-light-7);
    color: var(--el-text-color-primary);
    position: fixed;
    left: 0;
    top: 0;
    right: 0;
    width: 100%;
    height: 7%;
    min-height: 35px;
    text-align: right;
    padding: 0.5%;
}

.layout-container-demo .el-aside {
    color: var(--el-text-color-primary);
    background: var(--el-color-primary-light-7);
    position: fixed;
    left: 0;
    top: 7%;
    bottom: 0;
    width: 18%;
    min-width: 180px;
    /* z-index: 999; */
    /*z-index: 999; /* 確保側欄覆蓋在header上 */
    /* 根據 sidebarVisible 的狀態設置寬度 */
    /* width: '200px';
    overflow: hidden;
    transition: width 0.3s ease; 添加過度效果*/
}

.header-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
}

.layout-container-demo .toolbar {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 100%;
    margin-right: 2%;
    border: 0px;
}

.company_name {
    text-align: left;
    margin-left: 2%;
}

.container-top-right {
    display: flex;
    align-items: baseline;
}

</style>
  